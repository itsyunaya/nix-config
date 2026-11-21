# the reason this exists is because the upstream flake is antipattern hell.
# there's flake-utils, rec, nix-systems *and* the inputs haven't been updated
# in a few months. when will people learn to actually maintain their flakes...
{ pkgs, scenefx-src, ... }:
pkgs.stdenv.mkDerivation {
	pname = "scenefx";
	# no metadata to infer the proper versioning scheme from :(
	version = "0-unstable-unknown";

	src = scenefx-src;
	outputs = [ "out" "lib" ];

	# attrValues for nativeBuildInputs makes cmake appear before meson,
	# so nix tries to use it for configuring, which crashes the build
	dontUseCmakeConfigure = true;

	nativeBuildInputs = builtins.attrValues {
		inherit
			(pkgs)
			pkg-config
			meson
			cmake
			ninja
			scdoc
			wayland-scanner
			;
	};

	buildInputs = builtins.attrValues {
		inherit
			(pkgs)
			libdrm
			libxkbcommon
			pixman
			libGL # egl
			mesa # gbm
			wayland # wayland-server
			wayland-protocols
			wlroots_0_20
			libgbm
			libxcb
			libxcb-wm
			lcms2
			;
	};

	# https://github.com/mangowm/mango/pull/1387
	postPatch = ''
		substituteInPlace render/egl.c \
			--replace-fail 'attribs[atti++] = 2;' 'attribs[atti++] = 3;'
		substituteInPlace render/fx_renderer/shaders.c \
			--replace-fail 'glShaderSource(shader, 1, &src, NULL);' \
			'const char *prefix = (type == GL_FRAGMENT_SHADER) ? "#ifndef GL_FRAGMENT_PRECISION_HIGH\n#define GL_FRAGMENT_PRECISION_HIGH 1\n#endif\n" : ""; const GLchar *sources[] = { prefix, src }; glShaderSource(shader, 2, sources, NULL);'
	'';

	meta = {
		description = "A drop-in replacement for the wlroots scene API that allows wayland compositors to render surfaces with eye-candy effects";
		homepage = "https://github.com/wlrfx/scenefx";
		license = pkgs.lib.licenses.mit;
		platforms = pkgs.lib.platforms.linux;
		maintainers = [ pkgs.lib.maintainers.itsyunaya ];
	};
}
