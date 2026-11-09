{ inputs, pkgs }: let
	# https://github.com/mangowm/mango/pull/1387
	scenefx' = inputs.scenefx.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (oldAttrs: {
		postPatch = (oldAttrs.postPatch or "")
		+ ''
			substituteInPlace render/egl.c \
				--replace-fail 'attribs[atti++] = 2;' 'attribs[atti++] = 3;'
			substituteInPlace render/fx_renderer/shaders.c \
				--replace-fail 'glShaderSource(shader, 1, &src, NULL);' \
				'const char *prefix = (type == GL_FRAGMENT_SHADER) ? "#ifndef GL_FRAGMENT_PRECISION_HIGH\n#define GL_FRAGMENT_PRECISION_HIGH 1\n#endif\n" : ""; const GLchar *sources[] = { prefix, src }; glShaderSource(shader, 2, sources, NULL);'
			substituteInPlace render/fx_renderer/shaders/gradient.frag \
				--replace-fail 'int clamp(int value, int min_value, int max_value) {' 'int clamp_int(int value, int min_value, int max_value) {' \
				--replace-fail 'int inx = clamp(int(float(count) * factor), 0, count - 1);' 'int inx = clamp_int(int(float(count) * factor), 0, count - 1);' \
				--replace-fail 'int inx = clamp(int(smooth_inx), 0, count - 1);' 'int inx = clamp_int(int(smooth_inx), 0, count - 1);'
		'';
	});

	mango = pkgs.callPackage "${inputs.mango-src}/nix/default.nix" { scenefx = scenefx'; };
in
	mango
