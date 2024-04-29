{lib, config, pkgs, ...}:
let
  cfg = config.greetd;
in
with lib; {
  options.greetd = {
    enable = mkEnableOption "Enables greetd";

    greeter = mkOption {
      default = "agreety";
      description = "environment at greetd launch";
    };

    command = mkOption {
      default = "echo 'Please set a command for greetd' && sleep 5";
      description = "Executes after login";
    };
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
    
      settings.default_session.command = "${pkgs.greetd.${cfg.greeter}}/bin/${cfg.greeter} --cmd ${cfg.command}";
    };
  };
}
