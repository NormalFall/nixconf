{lib, pkgs, config, inputs, system, ...}:
let
  cfg = config.misc.zen-browser;
  browser-desktop-file = "zen.desktop";
in with lib; {
  options.misc.zen-browser.enable = mkEnableOption "Enables zen-browser default pakcage";

  imports = [ ../../../core/main-user ];

  config = {
    environment.systemPackages = [
      inputs.zen-browser.packages."${system}".default
    ];

    # Make sure to set it as default browser
    mainUser.modules = [
      ({...} : {
        xdg.mimeApps.defaultApplications = {
          "x-scheme-handler/http" = browser-desktop-file;
          "x-scheme-handler/https" = browser-desktop-file;
        };
      })
    ];
  };
}
