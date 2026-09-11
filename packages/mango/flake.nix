/*
The reason this Flake exists, is because upstream chose to use flake-parts
in their Flake, which results in a noticeable (rebuild) performance loss with
little to no benefits.
*/
{
	description = "Mango Flake";

	inputs = {
		# overridden with follows
		nixpkgs = {};

		mango = {
			url = "github:mangowm/mango";
			flake = false;
		};

		scenefx = {
			url = "github:wlrfx/scenefx";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, mango, scenefx }: let
		systems = [
			"x86_64-linux"
			"aarch64-linux"
		];

		forAllSystems = f: nixpkgs.lib.genAttrs systems f;
	in {
		packages = forAllSystems (system: let
			pkgs = import nixpkgs { inherit system; };

			# https://github.com/mangowm/mango/pull/1387
			scenefx' = scenefx.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (oldAttrs: {
				postPatch = (oldAttrs.postPatch or "")
				+ ''
					substituteInPlace render/egl.c \
					  --replace-fail 'attribs[atti++] = 2;' 'attribs[atti++] = 3;'
					substituteInPlace render/fx_renderer/shaders.c \
					  --replace-fail 'glShaderSource(shader, 1, &src, NULL);' \
					    'const char *prefix = (type == GL_FRAGMENT_SHADER) ? "#ifndef GL_FRAGMENT_PRECISION_HIGH\n#define GL_FRAGMENT_PRECISION_HIGH 1\n#endif\n" : ""; const GLchar *sources[] = { prefix, src }; glShaderSource(shader, 2, sources, NULL);'
				'';
			});

			mango-pkg = pkgs.callPackage "${mango}/nix/default.nix" { scenefx = scenefx'; };
		in {
			mango = mango-pkg;
			default = mango-pkg;
		});

		nixosModules.mango = import "${mango}/nix/nixos-modules.nix" self;
	};
}
