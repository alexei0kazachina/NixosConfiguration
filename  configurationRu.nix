# конфигурационный файл nixos
# parted /dev/sda -- mklabel msdos
# parted /dev/sda -- mkpart primary 1MiB -16GiB
# parted /dev/sda -- mkpart primary linux-swap -16GiB 100%
# parted /dev/nvme0n1 -- mklabel msdos
# parted /dev/nvme0n1 -- mkpart primary 1MiB 100%
# mkfs.ext4 -L nixosnv /dev/nvme0n1p1
# mkfs.ext4 -L nixos /dev/sda1
# mkswap -L swap /dev/sda2
# swapon /dev/sda2
# mount /dev/disk/by-label/nixos /mnt
# nixos-generate-config --root /mnt
# nano /mnt/etc/nixos/configuration.nix
# nixos-install
# cfdisk 
# reboot
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Включаем результат сканирования железа.
      ./hardware-configuration.nix
    ];

  # Используем  GRUB 2 загрузчик.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Обозначте диск для установки  Grub.
   boot.loader.grub.device = "/dev/sda"; # или  "nodev" только для  efi 
   nixpkgs.config.allowUnfree = true; # для google-chrome ...
  # nixpkgs.config.allowBroken = true;
  # Обозначте ядро по умолчанию Linux 5.10   
   boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_15;
  
   networking.hostName = "nixos"; # Обозначение имени-хоста hostname.
   networking.wireless.enable = true;  # Включить поддержку  wireless via wpa_supplicant.

  # Установить часовой пояс.
   time.timeZone = "Europe/Tiraspol";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

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


  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.al = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [ 
kicad-unstable
android-studio
anydesk
arcan.espeak
arduino
audacity
automake
bespokesynth
binutils
bison
boxes
cabal-install
ccache
clang
cmake
code-browser-gtk
conky
curl
dfu-util
dolphin
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
gcc
gettext
ghc
git
glxinfo
gmp
gnatcoll-lzma
gnome-latex
gnome.gedit
gnome.gnome-boxes
gnome.nautilus
go
go-font
google-chrome
google-fonts
gperf
gtk-frdp
gtk3
gtk4
hack-font
haskell-language-server
haskellPackages.ghcup
help2man
htop
hydra-unstable
jre8
kate
konsole
latexrun
libffi
libmodbus
libtool
libusb1
libreoffice-qt
lshw
matterbridge
mc
minicom
monero
monitor
ncurses
neofetch
neovim
nginx
ninja
nodejs-17_x
openssl
owl-lisp
pciutils
#php
pkg-config
#postgresql_14
psensor
pulseaudio
putty
python310
qbittorrent
quakespasm
quantum-espresso
remmina
screen
ssh-tools
sshlatex
stack
staruml
steam
stm32cubemx
stm32flash
stm32loader
synapse
tdesktop
tectonic
texinfo
texmaker
texstudio
ubuntu_font_family
unzip
usbutils
ventoy-bin
vgrep
vim
vimb
wget
which
xmrig
xorg.xauth
xrdp
xz
zip
   ];

 nix = {
    package = pkgs.nixUnstable; # or versioned attributes like nix_2_4
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
    enableSSHSupport = true;
   };

  # List services that you want to enable:
xdg.portal.enable = true;
   services.nginx.enable = true;
 #  services.postgresql.enable = true;
   services.sshd.enable = true;
   services.flatpak.enable = true;
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

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
  system.stateVersion = "22.05"; # Did you read the comment? cd /home/al/Загрузки
}

