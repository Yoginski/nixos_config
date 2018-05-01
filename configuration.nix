{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  powerManagement.cpuFreqGovernor = "powersave";

  hardware.bumblebee.enable = true;
  hardware.bumblebee.pmMethod = "bbswitch";

  boot.kernelParams = [ "acpi_rev_override" ];
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.gfxmodeEfi = "1024x768";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/b88e691a-9492-4d31-9ef9-a92eea78c676";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  powerManagement.enable = true;

  time.timeZone = "Asia/Bishkek";

  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    wget vim firefox htop curl ranger lm_sensors liberation_ttf powertop
    gnome3.gnome-tweak-tool arc-theme arc-icon-theme moka-icon-theme git
    tdesktop vscode gimp jhead unzip xdg-user-dirs exiftool perlPackages.ArchiveZip
    linuxPackages.perf go nmap lshw skypeforlinux gcc libpcap pkgconfig
    libnetfilter_queue libnfnetlink radare2 python36Packages.binwalk
    wireshark tshark pciutils unrar glxinfo libreoffice-fresh
  ];

  services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.libinput.disableWhileTyping = true;
  services.xserver.videoDrivers = [ "modesetting" ];
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  system.stateVersion = "18.03";
}
