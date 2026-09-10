{ config, lib, pkgs, modulesPath, ... }: {
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot = {
		loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;
		kernelPackages = pkgs.linuxPackages_latest;
		kernelModules = [ "kvm-amd" ];

		initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];

		# agony
		kernel.sysctl = { "fs.inotify.max_user_watches" = 1048576; };
	};

	system.etc.overlay.enable = true;

	nixpkgs = let
		insecurePkgs = [ ];

		hasItems = builtins.length insecurePkgs > 0;
		warningMsg =
			"Currently the following insecure packages are permitted to be installed: "
			+ builtins.concatStringsSep ", " insecurePkgs;
	in {
		hostPlatform = lib.mkDefault "x86_64-linux";

		config = {
			allowUnfree = true;
			permittedInsecurePackages = lib.warnIf hasItems warningMsg insecurePkgs;
		};
	};

	networking = {
		hostName = "juno";
		networkmanager.enable = true;
	};

	hardware = {
		cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

		graphics.enable = true;

		nvidia = {
			modesetting.enable = true;
			open = true;
			nvidiaSettings = true;
		};

		bluetooth = {
			enable = true;
			powerOnBoot = false;
			settings.General = {
				Experimental = true;
				FastConnectable = true;
			};
		};
	};

	security = {
		# enable the little stars when typing my password (useful because im bad at typing :p)
		sudo.extraConfig = ''
			Defaults env_reset,pwfeedback
		'';

		pam.services.ly.enableGnomeKeyring = true;
	};

	swapDevices = [{
		device = "/var/lib/swapfile";
		size = 16 * 1024; # 16 gb
		# see https://wiki.nixos.org/wiki/Swap#discard
		options = [ "discard" ];
	}];

	boot.zswap.enable = true;
}
