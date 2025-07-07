# Still not done, do NOT use in current state.
# Might not be good idea at all after all.
{ lib, ... }:

let

  defaultAttrs = { attrs, isSudo ? false }: 
    {
      isNormalUser = true;
      extraGroups = lib.optional [ "wheel" ];
    };

in {
  inherit defaultAttrs;
}

