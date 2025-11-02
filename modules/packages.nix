{
  pkgs,
  lib,
  exclude_packages ? [ ],
}:
let
  # Essential Hyprland packages - cannot be excluded
  hyprlandPackages = with pkgs; [
    hyprshot
    hyprpicker
    hyprsunset
    brightnessctl
    pamixer
    playerctl
    gnome-themes-extra
    pavucontrol
  ];

  # Essential system packages - cannot be excluded
  systemPackages = with pkgs; [
    git
    vim
    libnotify
    nautilus
    alejandra
    blueberry
    clipse
    fzf
    zoxide
    ripgrep
    eza
    fd
    curl
    unzip
    wget
    gnumake
    wlr-randr
  ];

  # Discretionary packages - can be excluded by user
  discretionaryPackages =
    with pkgs;
    [
      # TUIs
      lazygit
      lazydocker
      powertop
      fastfetch
      newsboat

      # GUIs
      vlc

      # Development tools
      gh

      # Containers
      docker-compose
      ffmpeg
    ]
    ++ lib.optionals (pkgs.system == "x86_64-linux") [
      typora
    ];

  # Only allow excluding discretionary packages to prevent breaking the system
  filteredDiscretionaryPackages = lib.lists.subtractLists exclude_packages discretionaryPackages;
  allSystemPackages = hyprlandPackages ++ systemPackages ++ filteredDiscretionaryPackages;
in
{
  # Regular packages
  systemPackages = allSystemPackages;

  homePackages = with pkgs; [
    grml-zsh-config
  ];
}
