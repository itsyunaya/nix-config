{ types, ... }: {
	inputs = {
		mkWrapper.from = { parent }: parent.mkWrapper;
		nixpkgs.from = { parent }: parent.nixpkgs;
	};

	options = {
		flags = {
			type = types.listOf types.string;
			default = ["--quiet" "--noask" "--absolute" "--dir" "/run/user/1000/keychain" ];
			description = "Flags to be appended by default when running Keychain";
		};

		keys = {
			type = types.listOf types.string;
			default = [ "id_ed25519" "id_ed25519_cl" "ceres_key" ];
			description = "Keys to be appended by default when running Keychain";
		};

		package = {
			type = types.derivation;
			defaultFunc = { inputs }: inputs.nixpkgs.pkgs.keychain;
			description = "The keychain package to be wrapped";
		};
	};

	impl = { options, inputs }:
		if options ? flags
		then let
			flags = options.flags ++ options.keys;
		in
			inputs.mkWrapper {
				inherit (options) package; inherit flags;
			}
		else options.package;
}
