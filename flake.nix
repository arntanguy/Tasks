{
  description = "Nix flake for Tasks";
  inputs.mc-rtc-nix.url = "github:mc-rtc/nixpkgs";
  inputs.rbdyn.url = "github:jrl-umi3218/RBDyn/pull/138/head";
  # inputs.rbdyn.url = "path:/home/arnaud/devel/mc-rtc-nix/workspace/RBDyn";

  outputs =
    inputs:
    inputs.mc-rtc-nix.lib.mkFlakoboros inputs (
      { lib, ... }:
      {
        overlays = [
          inputs.rbdyn.overlays.flakoboros
        ];

        overrideAttrs.tasks = {pkgs-final, drv-prev, ...}: {
          src = lib.cleanSource ./.;
          nativeBuildInputs = with pkgs-final; [
            jrl-cmakemodules
          ] ++ drv-prev.nativeBuildInputs;
        };
      }
    );
}
