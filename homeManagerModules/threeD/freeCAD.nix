{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.threeD.freeCAD;
in {
  options.my.threeD = {
    freeCAD = {
      enable = lib.mkEnableOption "Enable the FreeCAD module.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.freecad

      # Override to modify desktop file to include env var.
      # This seems to be extremely annoying because of build time.
      # I am now using an activation script instead.
      #(pkgs.freecad.overrideAttrs (oldAttrs: {
      #postInstall =
      #(oldAttrs.postInstall or "")
      #+ ''
      #substituteInPlace $out/share/applications/org.freecad.FreeCAD.desktop \
      #--replace "Exec=FreeCAD - --single-instance %F" "Exec=env QT_QPA_PLATFORM=xcb FreeCAD - --single-instance %F"
      #'';
      #}))
    ];

    # Script to make desktop entry with correct Exec line for actuallly working on
    # wayland without segfault by setting env var. (Copies the original for everything else.)
    home.activation.freeCadDestkop = lib.hm.dag.entryAfter ["writeBoundary"] ''
      HOME_MANAGER_DESK_FILE="${pkgs.freecad}/share/applications/org.freecad.FreeCAD.desktop"
      HOME_DESK_DIR="$HOME/.local/share/applications/"

      mkdir -p $HOME_DESK_DIR
      if [ -f $HOME_MANAGER_DESK_FILE && ! -f $HOME_DESK_DIR/org.freecad.FreeCAD.desktop ]; then
        cp $HOME_MANAGER_DESK_FILE $HOME_DESK_DIR
        ${pkgs.gnused}/bin/sed -i 's|Exec=FreeCAD|Exec=env QT_QPA_PLATFORM=xcb FreeCAD|' "$HOME_DESK_DIR/org.freecad.FreeCAD.desktop"
      else
        echo "Warning: FreeCAD desktop file not found."
      fi
    '';
  };
}
