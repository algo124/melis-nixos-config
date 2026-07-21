# Algo's NixOS Config

{ config, inputs, lib, pkgs, ... }:

let

# reaper-wrapped script credit to Man2 of the NixOS Discord.
# Gets Reaper plugins like spectral-compressor working
reaper-wrapped = pkgs.symlinkJoin {
	name = "reaper-wrapped";
	paths = [ pkgs.reaper ];
	buildInputs = [ pkgs.makeWrapper ];
	postBuild = ''
		wrapProgram $out/bin/reaper \
		--prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath [
			pkgs.libxcb
			pkgs.xcbutilwm
			pkgs.libX11
			pkgs.libXcursor
			pkgs.libXrandr
			pkgs.libGL
		]}
	'';
};

in

{

# Temp ?
nixpkgs.config.permittedInsecurePackages = ["electron-39.8.10"];

# Boot Loader
boot.loader = {
	systemd-boot.enable = true;
	systemd-boot.configurationLimit = 3;
	efi.canTouchEfiVariables = true;
	timeout = 10;
};

# Misc
system.stateVersion = "25.11"; # Don't touch this. It won't update your system.
services.journald.extraConfig = "SystemMaxUse=100M";
networking.hostName = "melis";
networking.networkmanager.enable = true;
programs.xwayland.enable = true;
programs.fish.enable = true;
programs.steam.enable = true;
musnix.enable = true;
nixpkgs.config.allowUnfree = true; # Allows proprietary packages.
nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Locale
i18n.defaultLocale = "en_US.UTF-8";
i18n.extraLocaleSettings = { LC_ALL = "en_US.UTF-8"; };
time.timeZone = "America/Los_Angeles";

# Services
services = {
	desktopManager.plasma6.enable = true;
	displayManager.sddm.enable = true;
	displayManager.sddm.wayland.enable = true;
};

# Sound
security.rtkit.enable = true;
services.pipewire = {
	enable = true;
	pulse.enable = true;
	alsa.enable = true;
	jack.enable = true;
};

# Syncthing
services.syncthing = {
	enable = true;
	openDefaultPorts = true;
    	group = "users";
   	user = "algo";
    	dataDir = "/home/algo";
    	configDir = "/home/algo/.config/syncthing";
};

# User
users.users.algo = {
	isNormalUser = true;
	extraGroups = [ "wheel" "audio" "networkmanager" "i2c" ];
	packages = with pkgs; [ tree ];
	shell = pkgs.fish;
	useDefaultShell = true;
};

# Hyprland
programs.hyprland = {
 	enable = true;
	package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
	portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
 	xwayland.enable = true;
};

# Thunar
programs.thunar.enable = true;
programs.thunar.plugins = with pkgs; [
	thunar-archive-plugin
	thunar-volman
];

# File manager extensions
services = {
	gvfs.enable = true;
	tumbler.enable = true;
	udisks2.enable = true;
};

# Thunar to Use Alacritty
xdg.terminal-exec = {
	enable = true;
	settings = {
		default = [ "alacritty.desktop" ];
	};
};

# Neovim
programs.neovim = {
	enable = true;
	defaultEditor = true;
};

# Environment Variables
environment.variables = {
	EDITOR = "nvim";
	TERMINAL = "alacritty";
	BROWSER = "librewolf";
};

# Fonts
fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
	noto-fonts
	noto-fonts-cjk-sans
	noto-fonts-color-emoji
	liberation_ttf
	fira-code
	fira-code-symbols
];

environment.systemPackages = with pkgs; [
	# Frequently Used
	neovim # alias: v
	bat # cat alt
	eza # ls alt
	fastfetch # backend for hf
	hyfetch # alias: hf
	# meh # image viewer
	ripgrep # use rg
	catppuccinifier-cli
    	# Basics
	nano vim
	brightnessctl
	playerctl
	imagemagick
	wget
	gcc glibc cmake
	python3
	openssh
	git gh # git cli
	unzip
	ddcutil ddcui
	toybox # Unix Command Line Utils
	ffmpeg
	dbus
	dunst
	xwayland
	xsettingsd
	wayland-utils
	xdg-desktop-portal
	xdg-desktop-portal-gtk
	wl-clipboard
	yt-dlp
	hardinfo2
	ffmpeg
	sassc
	# KDE
	kdePackages.kcalc
	kdePackages.kclock
	kdePackages.sddm-kcm
	kdePackages.partitionmanager
	kdePackages.xdg-desktop-portal-kde
	kdePackages.plasma-pa
	kdePackages.ktorrent
	kdePackages.kdenlive
	kdePackages.kamoso
	# Hyprland
	hyprpaper
	hyprtoolkit
	hyprpolkitagent
	hyprshot
	# Theming
	(pkgs.catppuccin-sddm.override {
		disableBackground = true;
	})
	# Applications
	vlc
	nautilus
	alacritty # alacritty preference
	librewolf # Meta+E
	zoom-us
	obs-studio
	prismlauncher
	element-desktop
	fluffychat
	obsidian # open with command line arg --disable-gpu
	vesktop # Turn off hardware acceleration
	bitwarden-desktop
	libreoffice-qt
	foliate
	filezilla
	shotwell
	euphonica
	nicotine-plus
	nwg-look
	# Musicking
	reaper-wrapped
	pwvucontrol
	pipewire.jack
	wireplumber
	qpwgraph
	yabridge
	yabridgectl
	wineWow64Packages.yabridge # wine-staging 9.21
	winetricks
	alsa-lib
	alsa-oss
	alsa-utils
	# Music Plugins
	decent-sampler
	surge-xt
	plugdata
	vital
	airwindows-lv2
	chow-tape-model
	cardinal
];

environment.plasma6.excludePackages = with pkgs; [
	kdePackages.kdepim-runtime
	kdePackages.kmahjongg
	kdePackages.kmines
	kdePackages.konversation
	kdePackages.kpat
	kdePackages.ksudoku
	kdePackages.konqueror
	kdePackages.discover
];

}

