{
	fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/ae7b8368-606e-4a07-b495-916518e748a4";
			fsType = "ext4";
		};

		"/boot" = {
			device = "/dev/disk/by-uuid/A45D-0886";
			fsType = "vfat";
			options = [ "fmask=0077" "dmask=0077" ];
		};

		"/mnt/secondary" = {
			device = "/dev/disk/by-uuid/fa8cc4d8-b6c0-45c1-8d4a-5d776a176383";
			fsType = "ext4";
		};
	};
}
