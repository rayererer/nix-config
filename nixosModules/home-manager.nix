{ pkgs, inputs, lib, config, ... }: {

  options = {
    home-manager = {
      enable = lib.mkEnableOption "Enable the home-manager integration module";
    };
  };

  config = lib.mkIf config.home-manager.enable
  {
    home-manager."rayer" = {
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ../hosts/nixvm/home.nix
        inputs.self.outputs.homeManagerModules.default
      ];

    };
  };
}
