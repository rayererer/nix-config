{ lib, ... }:
let

  # Get all unique components from a containers attribute set
  # Example: { topbar = ["Clock"]; dropdown = ["Clock" "Battery"]; } -> ["Clock" "Battery"]
  getAllComponents = containers: lib.unique (lib.flatten (lib.attrValues containers));

  # Generate shell script lines to copy component files
  # componentPath: path to component source directory
  # components: list of component names
  # Returns: string of cp commands
  generateComponentCopyCommands =
    componentPath: components:
    lib.concatMapStringsSep "\n    " (comp: ''
      cp ${componentPath}/${comp}.qml $out/components/
    '') components;

  # Generate shell script lines to create container files from templates
  # containerPath: path to container template directory
  # containers: attrset of { containerName = [components]; }
  # Returns: string of template processing commands
  generateContainerFilesFromTemplates =
    containerPath: containers:
    lib.concatStringsSep "\n    " (
      lib.mapAttrsToList (
        name: components:
        let
          # Capitalize container name: topbar -> Topbar
          capitalizedName = lib.toUpper (lib.substring 0 1 name) + lib.substring 1 (-1) name;
          componentList = lib.concatMapStringsSep "\n    " (comp: "${comp} { }") components;
        in
        ''
          # Process ${capitalizedName} template
          TEMPLATE="import \"../components\" 
                    $(cat ${containerPath}/${capitalizedName}.template.qml)"
          COMPONENTS="${componentList}"

          OUT_PATH=$out/containers/${capitalizedName}.qml

          echo "''${TEMPLATE//\/\/ \{\{COMPONENTS\}\}/$COMPONENTS}" > $OUT_PATH
        ''
      ) containers
    );

  # Generate the main shell.qml entry point that QuickShell looks for
  # containers: attrset of { containerName = [components]; }
  # Returns: QML string for shell.qml
  generateShellQml = containers: ''
    import Quickshell
    import "containers"

    Scope {
      ${lib.concatMapStringsSep "\n  " (
        name:
        # Capitalize first letter: topbar -> Topbar
        let
          capitalizedName = lib.toUpper (lib.substring 0 1 name) + lib.substring 1 (-1) name;
        in
        "${capitalizedName} { }"
      ) (lib.attrNames containers)}
    }
  '';

  # Generate shell script command to create shell.qml
  # containers: attrset of { containerName = [components]; }
  # Returns: string of cat command
  generateShellQmlFile = containers: ''
    cat > $out/shell.qml << 'EOF'
    ${generateShellQml containers}
    EOF
  '';
in
{
  inherit
    getAllComponents
    generateComponentCopyCommands
    generateContainerFilesFromTemplates
    generateShellQmlFile
    ;
}
