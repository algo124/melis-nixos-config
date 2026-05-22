# GTK Configuration
{ pkgs, config, ... }: {

xdg.configFile =
        let
        	gtk4Dir = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0";
        in {
        	"gtk-4.0/assets".source = "${gtk4Dir}/assets";
        	"gtk-4.0/gtk.css".source = "${gtk4Dir}/gtk.css";
		"gtk-4.0/gtk-dark.css".source = "${gtk4Dir}/gtk-dark.css";
        };

gtk = {
	enable = true;
	theme = {
		name = "catppuccin-mocha-pink";
		package = pkgs.catppuccin-gtk.override {
			accents = ["pink"];
			variant = "mocha";
		};
	};
	iconTheme = {
		name = "Papirus";
		package = pkgs.catppuccin-papirus-folders.override {
   			flavor = "mocha";
    			accent = "pink";
  		};
	};
	cursorTheme = {
        	name = "catppuccin-mocha-pink-cursors";
        	package = pkgs.catppuccin-cursors.mochaPink;
        	size = 24;
      	};
};

}
