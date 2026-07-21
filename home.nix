# Home.nix holds home-manager imports
{ ... }: {

home.stateVersion = "25.11";
home.username = "algo";
home.homeDirectory = "/home/algo";

xdg.enable = true;

imports = [
	./dots/alacritty.nix
	./dots/cliphist.nix
	./dots/fastfetch.nix
	./dots/fish.nix
	./dots/git.nix
	./dots/gtk.nix # possibly remove
	./dots/hyprland.nix
	./dots/librewolf.nix
	./dots/mpd.nix
	./dots/mpdscribble.nix
];

}

