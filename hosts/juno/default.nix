{ fnLib, self, ... }: let
	username = "ashley";
in {
	imports = [
		(fnLib.recImport ./. { inherit username; })
		"${self}/modules/"
		"${self}/modules/spicetify"
	];
}
