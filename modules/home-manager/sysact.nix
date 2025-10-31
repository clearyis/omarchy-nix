{ config, pkgs, lib, ... }:

{
  # Install the script into $HOME/.local/bin/sysact via home-manager
  home.file."bin/sysact" = {
    source = ../assets/bin/sysact;
    executable = true;
  };
}
