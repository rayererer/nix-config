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
  # The parts between // {{COMPONENTS_BEGIN}} and // {{COMPONENTS_END}} will be
  # checked and components not activated in nix will be removed from the file.
  # containerPath: path to container template directory
  # containers: attrset of { containerName = [components]; }
  # Returns: string of template processing commands
  generateContainerFilesFromTemplates =
    containerPath: containers:
    lib.concatStringsSep "\n    " (
      lib.mapAttrsToList (
        name: enabledComponents:
        let
          capitalizedName = lib.toUpper (lib.substring 0 1 name) + lib.substring 1 (-1) name;
        in
        ''
          # Process ${capitalizedName} template
          TEMPLATE=$(cat ${containerPath}/${capitalizedName}.template.qml)

          # Extract the section between markers
          BEFORE=$(echo "$TEMPLATE" | sed -n '1,/\/\/ {{COMPONENTS_BEGIN}}/p' | sed '$d')
          COMPONENTS_SECTION=$(echo "$TEMPLATE" | sed -n '/\/\/ {{COMPONENTS_BEGIN}}/,/\/\/ {{COMPONENTS_END}}/p' | sed '1d;$d')
          AFTER=$(echo "$TEMPLATE" | sed -n '/\/\/ {{COMPONENTS_END}}/,$p' | sed '1d')

          # Parse each component block and filter
          FILTERED_COMPONENTS=""
          CURRENT_COMPONENT=""
          BRACE_COUNT=0

          while IFS= read -r line; do
            # Check if line starts a component (matches enabled list)
            ${lib.concatMapStringsSep "\n          " (comp: ''
              if [[ "$line" =~ ^[[:space:]]*${comp}[[:space:]]*\{ ]]; then
                CURRENT_COMPONENT="${comp}"
                BRACE_COUNT=1
                FILTERED_COMPONENTS="$FILTERED_COMPONENTS$line"$'\n'
                continue
              fi
            '') enabledComponents}
            
            # If we're inside an enabled component, track braces
            if [[ -n "$CURRENT_COMPONENT" ]]; then
              FILTERED_COMPONENTS="$FILTERED_COMPONENTS$line"$'\n'
              BRACE_COUNT=$((BRACE_COUNT + $(echo "$line" | tr -cd '{' | wc -c)))
              BRACE_COUNT=$((BRACE_COUNT - $(echo "$line" | tr -cd '}' | wc -c)))
              
              if [[ $BRACE_COUNT -eq 0 ]]; then
                CURRENT_COMPONENT=""
              fi
            fi
          done <<< "$COMPONENTS_SECTION"

          # Combine and write
          {
            echo "$BEFORE"
            echo "$FILTERED_COMPONENTS"
            echo "$AFTER"
          } > $out/containers/${capitalizedName}.qml
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
