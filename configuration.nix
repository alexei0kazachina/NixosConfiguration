

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, nixpkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
   boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_16;
   nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;
  # hardware.nvidia.package = [ "nvidiaLegacy304" ];
    boot.initrd.kernelModules = [ "amdgpu" ];
   networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
   time.timeZone = "Europe/Tiraspol";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "ru_RU.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
   };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  programs.kdeconnect.enable = true;
  programs.partition-manager.enable = true;
  sound.mediaKeys.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  # https://nixos.wiki/wiki/AMD_GPU
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
 # services.xserver.desktopManager.pantheon.enable = true;
 # services.xserver.windowManager.xmonad.enable = true;
 # services.xrdp.enable = true;
 # services.xrdp.defaultWindowManager = "x11";
 # networking.firewall.allowedTCPPorts = [ 3389 ];

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.al = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user. 
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
# support both 32- and 64-bit applications
    wineWowPackages.stable
    # winetricks and other programs depending on wine need to use the same wine version
    #(winetricks.override { wine = wineWowPackages.staging; })
android-studio
arcan.espeak
arduino
audacity
automake
anydesk
bespokesynth
binutils
bison
cabal-install
ccache
clang
cmake
code-browser-gtk
curl
dfu-util
dolphin
dconf
eclipses.eclipse-cpp
ekam
espeak-classic
espeakedit
esphome
esptool
ffmpeg
firefox
flex
flutter
foxtrotgps
freerdp
gawk
gettext
ghc
gh
git
glxinfo
gnatcoll-lzma
gnome-latex
go
go-font
google-chrome
google-fonts
gperf
gtk3
gtk4
gtk-frdp
hack-font
haskell-language-server
help2man
htop
hydra-unstable
jre8
kate
kicad-unstable
konsole
latexrun
libffi
libmodbus
libtool
libusb1
lshw
libreoffice-qt
matterbridge
mc
minicom
monitor
ncurses
neofetch
nginx
ninja
nodejs-17_x
owl-lisp
openssl
pciutils
php
pkg-config
psensor
pulseaudio
putty
python310
qbittorrent
quakespasm
remmina
screen
sshlatex
ssh-tools
stack
stm32cubemx
stm32flash
stm32loader
staruml
synapse
tdesktop
tectonic
texinfo
texmaker
texstudio
ubuntu_font_family
unzip
usbutils
vgrep
vim
ventoy-bin
xrdp
xz
gnome.gnome-boxes
wget
xoscope
bitscope.meter
bitscope.proto
corrscope
dsview
lxi-tools
openhantek6022
lsp-plugins
dconf
minicom
nmap-graphical
pies
ruby
wget
nixops
tree
   ];
 nix = {
    package = pkgs.nixUnstable; # or versioned attributes like nix_2_4
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  hardware.steam-hardware.enable = true;
  hardware.opengl.driSupport = true; 
  hardware.opengl.enable = true;
  programs.steam.enable = true;
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;
  # services.nginx.enable = true;
  # services.postgresql.enable = true;
   services.sshd.enable = true;
   services.flatpak.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
