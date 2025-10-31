{ config, pkgs, lib, ... }:

{
  # Install the script into $HOME/.local/bin/sysact via home-manager
  home.file.".local/bin/sysact" = {
    source = ../assets/bin/sysact;
    executable = true;
  };
}
