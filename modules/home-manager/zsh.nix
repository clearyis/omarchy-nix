{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    initContent = ''
      source "${pkgs.grml-zsh-config}/etc/zsh/zshrc"
    '';
  };
}
