{ lib, pkgs, stdenv, ... }: let
	inherit (lib) cleanSourceWith cleanSourceFilter;
	inherit (builtins) attrValues;
in
	stdenv.mkDerivation {
		pname = "lc";
		version = "0.1";

		src = cleanSourceWith {
			src = ./.;
			filter = path: type: let
				base = baseNameOf (toString path);
			in
				(cleanSourceFilter path type) && base != "build" && base != "result";
			name = "source";
		};

		nativeBuildInputs = attrValues {
			inherit
				(pkgs)
				meson
				ninja
				pkg-config
				;
		};

		buildInputs = attrValues {
			inherit
				(pkgs)
				curl
				;
		};

		meta = {
			description = "lc - quickly generate license files";
			license = lib.licenses.eupl12;
			maintainers = [ lib.maintainers.itsyunaya ];
			platforms = lib.platforms.unix;
		};
	}
