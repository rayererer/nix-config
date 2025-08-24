{
  pkgs,
  lib,
  config,
  ...
}: let
  zenCfg = config.my.browsers.zen;
  cfg = zenCfg.syncing;
  profilePath = "${config.home.homeDirectory}/.zen/${cfg.profile}";

  versionedFiles = [
    "containers.json"
    "users.js"
    "zen-keyboard-shortcuts"
  ];

  unversionedFiles = [
    "sessionstore.jsonlz4"
  ];

  generateCopyCommands = files:
    lib.concatMapStringsSep "\n" (file: ''
      [[ -f "${profilePath}/${file}" ]] && cp "${profilePath}/${file}" "./${file}" || true
    '')
    files;

  setupRepo = pkgs.writeShellScript "zen-sync-setupRepo" ''
    set -euo pipefail

    TEMP_DIR=''${${pkgs.coreutils}/bin/mktemp-d)}

    echo "[REPO SETUP] Setting up git repository in: $TEMP_DIR"

    cd "$TEMP_DIR"

    # Initialize or update git repo
    if [[ ! -d ".git" ]]; then
      ${pkgs.git}/bin/git init
      ${pkgs.git}/bin/git remote add origin "${cfg.repoUrl}"
    fi

    # Try to fetch existing branches
    ${pkgs.git}/bin/git fetch origin main 2>/dev/null || echo "[REPO SETUP] No main branch yet"
    ${pkgs.git}/bin/git fetch origin unversioned-data 2>/dev/null || echo "[REPO SETUP] No unversioned data branch yet"

    echo "[REPO SETUP] Git repository setup in: $TEMP_DIR"
    echo "$TEMP_DIR"  # Return the temp directory path
  '';

  updateVersioned = pkgs.writeShellScript "zen-sync-updateVersioned" ''
    set -euo pipefail

    WORK_DIR=''${1:?"Work directory required"}
    cd "$WORK_DIR"

    echo "[VERSIONED UPDATE] Updating versioned files in main branch"

    # Ensure we're on main branch
    ${pkgs.git}/bin/git checkout main 2>/dev/null || ${pkgs.git}/bin/git checkout -b main

    ${generateCopyCommands versionedFiles}

    # Commit if there are changes
    ${pkgs.git}/bin/git add -A
    if ! ${pkgs.git}/bin/git diff --cached --quiet; then
      ${pkgs.git}/bin/git commit -m "Update versioned config $(${pkgs.coreutils}/bin/date -Iseconds)"
      echo "[VERSIONED UPDATE] Committed versioned changes"
    else
      echo "[VERSIONED UPDATE] No versioned changes to commit"
    fi
  '';

  updateUnversioned = pkgs.writeShellScript "zen-sync-updateUnversioned" ''
    set -euo pipefail

    WORK_DIR=''${1:?"Work directory required"}
    cd "$WORK_DIR"

    echo "[UNVERSIONED UPDATE] Updating unversioned files on data branch"

    # Create/recreate orphan data branch (no history)
    ${pkgs.git}/bin/git checkout --orphan data-new 2>/dev/null || true
    ${pkgs.git}/bin/git rm -rf . 2>/dev/null || true

    # Copy unversioned files
    ${generateCopyCommands unversionedFiles}

    # Only commit if we have files
    if ${pkgs.coreutils}/bin/find . -maxdepth 1 -type f | ${pkgs.gnugrep}/bin/grep -q .; then
      ${pkgs.git}/bin/git add .
      ${pkgs.git}/bin/git commit -m "Data snapshot $(${pkgs.coreutils}/bin/date -Iseconds)"

      # Replace the old data branch
      ${pkgs.git}/bin/git branch -D data 2>/dev/null || true
      ${pkgs.git}/bin/git branch -m data-new data

      echo "[UNVERSIONED UPDATE] Updated data branch"
    else
      echo "[UNVERSIONED UPDATE] No unversioned files found"
    fi
  '';

  syncUpdate = pkgs.writeShellScript "zen-sync-update" ''
    set -euo pipefail

    echo "[UPDATE] Starting Zen browser sync update"

    # Verify profile exists
    if [[ ! -d "${profilePath}" ]]; then
      echo "[ERROR] Zen profile not found at: ${profilePath}"
      exit 1
    fi

    # Set up temporary git workspace
    TEMP_DIR=$(${setupRepo})
    trap "rm -rf $TEMP_DIR" EXIT

    echo "[UPDATE] Working in temporary directory: $TEMP_DIR"

    # Update versioned files first
    ${updateVersioned} "$TEMP_DIR"

    # Push versioned changes
    cd "$TEMP_DIR"
    ${pkgs.git}/bin/git push origin main || echo "[WARNING] Failed to push main branch"

    # Update unversioned files
    ${updateUnversioned} "$TEMP_DIR"

    # Push unversioned changes (force push for data branch)
    ${pkgs.git}/bin/git push --force origin unversioned-data || echo "[WARNING] Failed to push unversioned-data branch"

    echo "[UPDATE] Sync update completed successfully"
  '';

  retrieveVersioned =
    pkgs.writeShellScript "zen-sync-retrieveVersioned" ''
    '';

  retrieveUnversioned =
    pkgs.writeShellScript "zen-sync-retrieveUnversioned" ''
    '';

  syncRetrieve = pkgs.writeShellScript "zen-sync-update" ''

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

    systemd.user.services.zen-syncing-service = {
    };
  };
}
