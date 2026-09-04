{
	explode = "poweroff";

	# git
	gs = "git status";
	gc = "git commit -v";
	gd = "git diff --name-only --relative --diff-filter=d -z | xargs -0 bat --diff";
	gp = "git add --patch";
}
