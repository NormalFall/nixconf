{lib, pkgs, config, inputs, system, ...}:
let
  cfg = config.misc.zen-browser;
  browser-desktop-file = "zen-beta.desktop";
in with lib; {
  options.misc.zen-browser.enable = mkEnableOption "Enables zen-browser default pakcage";

  imports = [ ../../../core/main-user ];

  config = {
    environment.systemPackages = [
      inputs.zen-browser.packages."${system}".beta
    ];

    # Make sure to set it as default browser
    mainUser.modules = [
      inputs.zen-browser.homeModules.default
      ({...} : {
        programs.zen-browser = {
          enable = true;
        };
        programs.zen-browser.policies = let
          mkExtensionSettings = builtins.mapAttrs (_: {pluginId, privateAllowed ? false}: {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = privateAllowed;
          });
        in {
          # Policies
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };

          # Plugins
          ExtensionSettings = mkExtensionSettings {
            "adnauseam@rednoise.org" = { pluginId = "adnauseam@rednoise.org"; privateAllowed = true; };
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = { pluginId = "bitwarden-password-manager"; };
            "addon@darkreader.org" = { pluginId = "addon@darkreader.org"; privateAllowed = true; };
            "jid1-BoFifL9Vbdl2zQ@jetpack" = { pluginId = "jid1-BoFifL9Vbdl2zQ@jetpack"; privateAllowed = true; };
            "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = { pluginId = "return-youtube-dislikes"; };
          };
        };
      })
      ({...} : {
        xdg.mimeApps.defaultApplications = {
          "x-scheme-handler/http" = browser-desktop-file;
          "x-scheme-handler/https" = browser-desktop-file;
          "application/pdf" = browser-desktop-file;
        };
      })
    ];
  };
}
