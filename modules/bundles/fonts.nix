{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    font-awesome
  ]
  ++ (builtins.filter (x: (builtins.isAttrs x && builtins.hasAttr "outputs" x)) (builtins.attrValues pkgs.nerd-fonts));
}
