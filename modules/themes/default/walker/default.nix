{lib, inputs, ...}: {
  imports = [ ../../../core/main-user ];
  config.mainUser.modules = [
    (inputs.walker.homeManagerModules.default)
    ({
      programs.walker = {
        enable = true;
        runAsService = true;
        config = {
          theme = "nixos";
          keybinds.quick_activate = ["ctrl 1" "ctrl 2" "ctrl 3" "ctrl 4"];
          providers.default = ["desktopapplications" "calc"];

          providers.prefixes = [
            {provider = "clipboard"; prefix = "`";}
            {provider = "providerlist"; prefix = ";";}
          ];
        };
        themes.nixos.style = builtins.readFile ./style.css;
      };
    })
  ];
}
