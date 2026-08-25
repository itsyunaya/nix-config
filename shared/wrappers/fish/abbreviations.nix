{
	explode = "poweroff";

	# git
	# see https://github.com/sharkdp/bat#git-diff
	gd = "git diff --name-only --relative --diff-filter=d -z | xargs -0 bat --diff";
}
