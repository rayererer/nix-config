{
  pkgs,
  lib,
  config,
  ...
}: let
  zenCfg = config.my.browsers.zen;
  cfg = zenCfg.syncing;
  zenPath = "${zenCfg.zenPath}";
  profilePath = "${zenPath}/Profiles/${cfg.profile}";
  repoPath = "${zenPath}/custom-zen-syncing";

  versionedFiles = [
    "containers.json"
    "user.js"
    "zen-keyboard-shortcuts"
  ];

  unversionedFiles = [
    "sessionstore.jsonlz4"
  ];

  generateUpdateCopyCommands = files:
    lib.concatMapStringsSep "\n" (file: ''
      [[ -f "${profilePath}/${file}" ]] && cp -r "${profilePath}/${file}" "${repoPath}/${file}" || true
    '')
    files;

  generateRetrieveCopyCommands = files:
    lib.concatMapStringsSep "\n" (file: ''
      [[ -f "${repoPath}/${file}" ]] && cp -r "${repoPath}/${file}" "${profilePath}/${file}" || true
    '')
    files;

  setupRepo = pkgs.writeShellScript "zen-sync-setupRepo" ''
    set -euo pipefail

    echo "[REPO SETUP] Setting up git repository in: ${repoPath}"

    if [[ ! -d "${repoPath}" ]]; then
      echo "[REPO SETUP] No directory found at ${repoPath} - creating it."
      mkdir "${repoPath}"
    fi

    if [[ ! -d "${repoPath}/.git" ]]; then
      echo "[REPO SETUP] Directory is not a git repo - cloning the remote."
      ${pkgs.git}/bin/git clone "${cfg.repoUrl}" "${repoPath}"
    fi

    echo "[REPO SETUP] Git repository setup done in: ${repoPath}"
  '';

  updateVersioned = pkgs.writeShellScript "zen-sync-updateVersioned" ''
    set -euo pipefail

    cd "${repoPath}"

    echo "[VERSIONED UPDATE] Updating versioned files in main branch"

    # Ensure we're on main branch
    ${pkgs.git}/bin/git checkout main 2>/dev/null || ${pkgs.git}/bin/git checkout -b main

    ${generateUpdateCopyCommands versionedFiles}

    # Commit and push if there are changes
    ${pkgs.git}/bin/git add -A
    if ! ${pkgs.git}/bin/git diff --cached --quiet; then
      ${pkgs.git}/bin/git commit -m "Update versioned config $(${pkgs.coreutils}/bin/date -Iseconds)"
      echo "[VERSIONED UPDATE] Committed versioned changes"

      echo "[VERSIONED UPDATE] Pulling the versioned files."
      ${pkgs.git}/bin/git pull || echo "[WARNING] Failed to pull main branch"

      echo "[VERSIONED UPDATE] Pushing the versioned files."
      ${pkgs.git}/bin/git push origin main || echo "[WARNING] Failed to push main branch"

    else
      echo "[VERSIONED UPDATE] No versioned changes to commit"
    fi
  '';

  updateUnversioned = pkgs.writeShellScript "zen-sync-updateUnversioned" ''
    set -euo pipefail

    cd "${repoPath}"

    echo "[UNVERSIONED UPDATE] Updating unversioned files on data branch"

    # Create/recreate orphan data branch (no history)
    ${pkgs.git}/bin/git checkout --orphan unversioned-data-new 2>/dev/null || true
    ${pkgs.git}/bin/git rm -rf . 2>/dev/null || true

    # Copy unversioned files
    ${generateUpdateCopyCommands unversionedFiles}

    # Only commit and push if we have files
    if [[ ! -z "$( ls )" ]]; then
      ${pkgs.git}/bin/git add .
      ${pkgs.git}/bin/git commit -m "Data snapshot $(${pkgs.coreutils}/bin/date -Iseconds)"

      # Replace the old data branch and push
      ${pkgs.git}/bin/git branch -D unversioned-data 2>/dev/null || true
      ${pkgs.git}/bin/git branch -m unversioned-data-new unversioned-data

    echo "[UNVERSIONED UPDATE] Updated unversioned data branch"

    echo "[UNVERSIONED UPDATE] Force pushing the unversioned files."

    ${pkgs.git}/bin/git push --force origin unversioned-data || echo "[WARNING] Failed to push unversioned-data branch"
    else
      echo "[UNVERSIONED PDATE] No unversioned files found: Not doing anything"
    fi
  '';

  syncUpdate = pkgs.writeShellScript "zen-sync-update" ''
    set -euo pipefail

    echo "[UPDATE] Starting Zen browser sync update"

    if [[ ! -d "${profilePath}" ]]; then
      echo "[ERROR] Zen profile not found at: ${profilePath}"
      exit 1
    fi

    echo "[UPDATE] Ensuring repository is set up..."
    ${setupRepo}

    echo "[UPDATE] Updating the versioned files..."
    ${updateVersioned} "${repoPath}"

    echo "[UPDATE] Updating the unversioned files..."
    ${updateUnversioned} "${repoPath}"

    echo "[UPDATE] Sync update completed successfully"
  '';

  retrieveVersioned =
    pkgs.writeShellScript "zen-sync-retrieveVersioned" ''
      set -euo pipefail
    
      if [[ ! -d "${profilePath}" ]]; then
        echo "[ERROR] Zen profile not found at: ${profilePath}"
        exit 1
      fi

      # Copy for no risk of data loss in case of improper update before.
      ${generateUpdateCopyCommands versionedFiles}

      cd "${repoPath}"
    
      echo "[RETRIEVE VERSIONED] Retrieving versioned files from main branch"
    
      ${pkgs.git}/bin/git checkout main
      ${pkgs.git}/bin/git pull origin main || echo "[WARNING] Could not pull main branch"
      
      ${generateRetrieveCopyCommands versionedFiles}
      
      echo "[RETRIEVE VERSIONED] Versioned files retrieved"
    '';

  retrieveUnversioned =
    pkgs.writeShellScript "zen-sync-retrieveUnversioned" ''
      set -euo pipefail
    
      if [[ ! -d "${profilePath}" ]]; then
        echo "[ERROR] Zen profile not found at: ${profilePath}"
        exit 1
      fi

      # Copy for no risk of data loss in case of improper update before.
      ${generateRetrieveCopyCommands unversionedFiles}

      cd "${repoPath}"
    
      echo "[RETRIEVE UNVERSIONED] Retrieving unversioned files from unversioned-data branch"
    
      ${pkgs.git}/bin/git checkout unversioned-data
      ${pkgs.git}/bin/git pull origin unversioned-data || echo "[WARNING] Could not pull unversioned-data branch"
      
      ${generateRetrieveCopyCommands unversionedFiles}
      
      echo "[RETRIEVE UNVERSIONED] Unversioned files retrieved"
    '';

  syncRetrieve = pkgs.writeShellScript "zen-sync-update" ''
    set -euo pipefail

    echo "[RETRIEVE] Starting Zen browser sync retrieval"

    if [[ ! -d "${profilePath}" ]]; then
      echo "[ERROR] Zen profile not found at: ${profilePath}"
      exit 1
    fi

    echo "[RETRIEVE] Ensuring repository is set up..."
    ${setupRepo}

    echo "[RETRIEVE] Updating the versioned files..."
    ${retrieveVersioned} "${repoPath}"

    echo "[RETRIEVE] Updating the unversioned files..."
    ${retrieveUnversioned} "${repoPath}"

    echo "[RETRIEVE] Sync update completed successfully"
  '';
in {
  options.my.browsers.zen = {
    syncing = {
      profile = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          Sets the profile and enables my custom syncing module for the
          Zen Browser which makes use of a git repo, which you can specify
          url for if you want to change it. The sync makes it so that all
          necessary Zen stuff is synced, not just some stuff like with only
          using Mozilla sync.
        '';
      };

      repoUrl = lib.mkOption {
        type = lib.types.str;
        default = "git:zen-syncing";
        description = ''
          The url to clone the syncing repo from.
        '';
      };
    };
  };

  config = lib.mkIf (cfg.profile
    != null) {
    assertions = [
      {
        assertion = zenCfg.enable;
        message = ''
          Cannot set 'config.my.browsers.zen.syncing.enable' to true
          if 'config.my.browsers.zen.enable' is false.
        '';
      }
    ];

    # For testing
    home.packages = [
      (pkgs.writeShellScriptBin "zen-sync-update" ''exec ${syncUpdate} "$@"'')
      (pkgs.writeShellScriptBin "zen-sync-retrieve" ''exec ${syncRetrieve} "$@"'')
    ];

    systemd.user.services.zen-syncing-service = {
    };
  };
}
