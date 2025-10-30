{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.misc.obsidian;
in
with lib;
{
  options.misc.obsidian = {
    enable = mkEnableOption "Enables obsidian with configs";
  };

  imports = [ ../../../core/main-user ];

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.obsidian ];
    mainUser.modules = [(
      {
        programs.obsidian = {
          enable = true;

          defaultSettings = {
            corePlugins = [
              "backlink"
              "graph"
              "file-explorer"
              "global-search"
              "outgoing-link"
              "page-preview"
              "tag-pane"
              "word-count"
            ];
            communityPlugins = [
              (pkgs.callPackage ./livesync.nix {})
            ];
          };

          vaults."Work" = {
            enable = true;
            target = "Documents/Notes/Work";
          };
        };
      }
    )];
  };
}
