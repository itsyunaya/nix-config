{
	programs.git = {
		enable = true;
		config = {
			commit.gpgsign = true;
			tag.gpgSign = true;
			init.defaultBranch = "main";

			user = {
				name = "itsyunaya";
				email = "40719746+itsyunaya@users.noreply.github.com";
				signingKey = "198EA594738FED19";
			};
		};
	};
}
