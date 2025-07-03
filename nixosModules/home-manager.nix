{ pkgs, inputs, lib, config, ... }: {

  options.myOs.home-manager.enable = lib.mkEnableOption "Enable the home-manager integration module";

  config = lib.mkIf config.myOs.home-manager.enable
  {
    home-manager.sharedModules = [
      (import inputs.self.outputs.homeManagerModules.default { inherit lib pkgs config; })
    ];

    home-manager.extraSpecialArgs = { 
      inherit inputs; 
    };
  };
}
