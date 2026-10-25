# ArchLinux

Start with [Installation Guide](https://wiki.archlinux.org/title/Installation_guide)

When you reach section on partitioning disks switch to [LVM ON LUKS](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS).

## Partitions

This tool is a bit easier to set things up compared to `fdisk` or `parted`:

```bash
cfdisk /dev/nvme0n1
```

Setup 2 partitions:

| Purpose                    | Device         | Start   | End        | Sectors -  | Size   | Type             |
|----------------------------|----------------|---------|------------|------------|--------|------------------|
| boot                       | /dev/nvme0n1p1 | 2048    | 2099199    | 2097152    | 1G     | EFI System       |
| encrypted root, swap, home | /dev/nvme0n1p2 | 2099200 | 1953523711 | 1951424512 | 930.5G | Linux Filesystem |

Encrypted LVM on LUKS:

```bash
cryptsetup luksFormat /dev/nvme0n1p2

cryptsetup open /dev/nvme0n1p2 cryptlvm

pvcreate /dev/mapper/cryptlvm

vgcreate MainVolGroup /dev/mapper/cryptlvm

lvcreate -L 8G -n swap MainVolGroup
lvcreate -L 50G -n root MainVolGroup
lvcreate -l 100%FREE -n home MainVolGroup

mkfs.ext4 /dev/MainVolGroup/root
mkfs.ext4 /dev/MainVolGroup/home
mkswap /dev/MainVolGroup/swap

mount /dev/MainVolGroup/root /mnt
mount --mkdir /dev/MainVolGroup/home /mnt/home
swapon /dev/MainVolGroup/swap
```

Boot volume:

```bash
mkfs.fat -F32 /dev/nvme0n1p1
mount --mkdir /dev/nvme0n1p1 /mnt/boot
```

Go back to [Installation Guide](https://wiki.archlinux.org/title/Installation_guide).

Edit /etc/pacman.d/mirrolist and put Canada mirror list below Worldwide.

Install essential packages:

```bash
pacstrap /mnt base base-devel less fuse2 wget unzip vim xz \
    networkmanager lvm2 cryptsetup grub efibootmgr \
    linux linux-firmware linux-headers
```

Seems to generate an error about /etc/vconsole.conf missing. Do this and run pacstrap again:

```bash
cp /etc/vconsole.conf /mnt/etc/vconsole.conf
```

Configure system:

```bash
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime

hwclock --systohc

locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "hackmad" > /etc/hostname
```

Go to [Configuring mkinitcpio](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#Configuring_mkinitcpio_3) and finish rest of the setup for LVM on LUKS (see some configs needed below during this setup).

Edit /etc/mkinitcpio.conf and change this line:

```bash
HOOKS=(base systemd autodetect microcode modconf kms keyboard keymap sd-vconsole block sd-encrypt lvm2 filesystems fsck)
```

Regenerate initramfs:

```bash
mkinitcpio -P
```

To create a user with sudo access first run `visudo` and uncomment the line:

```bash
%wheel ALL=(ALL:ALL) ALL
```

Then:

```bash
useradd -m -G wheel -s /bin/bash ahmad
passwd ahmad
```

Install grub bootloader on the `nvme0n1` disk (not the partitions):

```bash
grub-install --efi-directory=/boot --bootloader-id=ArchLinux /dev/nvme0n1
```

```bash
PART_ID=$(blkid -o value -s UUID /dev/nvme0n1p2)
sed -i "s/\(GRUB_CMDLINE_LINUX_DEFAULT=.*quiet\)/\1 splash rd.luks.name=$PART_ID=cryptlvm root=\/dev\/MainVolGroup\/root/" /etc/default/grub
sed -i "s/^\(GRUB_GFXMODE\)=.*$/\1=1920x1080/" /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg
```

```bash
systemctl enable NetworkManager
```

## Post installation

```bash
sudo pacman -S zsh
chsh -s $(which zsh)

sudo pacman -S git
```

Edit /etc/pacman.conf and enable multilib by uncommenting following lines:

```bash
[multilib]
Include = /etc/pacman.d/mirrolist
```

Install Nvidia drivers and Vulkan SDK:

```bash
sudo pacman -S dkms nvidia-dkms nvidia-utils nvidia-settings lib32-nvidia-utils
sudo pacman -S vulkan-icd-loader vulkan-validation-layers vulkan-tools renderdoc shaderc
```

Add the following to /etc/mkinitcpio.conf:

```bash
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```

And run:

```bash
mkinitcpio -P
```

Add "nvidia_drm.modeset=1" to `GRUB_CMDLINE_LINUX_DEFAULT` /etc/default/grub and run:

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

Reboot.

## KDE Plasma (easier)

```bash
sudo pacman -S plasma-meta plasma-login-manager kde-applications-meta
sudo systemctl enable plasmalogin.service

sudo pacman -S print-manager system-config-printer cups
sudo systemctl enable cups.service
sudo systemctl start cups.service

sudo pacman -S blueman
sudo systemctl enable bluetooth.service

sudo pacman -S v4l-utils
```

## Other stuff

```bash
sudo pacman -S kitty thunderbird firefox
```

Performance kernel:

```bash
sudo pacman -S linux linux-zen
```

## Hyprland (lot of config necessary and is incomplete)

```bash
sudo pacman -S egl-wayland hyprland sddm \
    hyprpolkitagent hyprpaper hyprlauncher dunst dolphin \
    pipewire wireplumber xdg-desktop-portal-hyprland waybar
```

Run hyprland once:

```bash
start-hyprland
```

Hit Super+Q to launch terminal and check monitor config:

```bash
hyprctl monitors all
```

Note down the line that say DP-<n>:

```
Monitor DP-3 (ID 0):
...
```

Then stop hyprland:

```bash
hyprctl dispatch exit
```

Edit ~/.config/hypr/hyprland.conf and set:

```bash
monitor = DP-3, 3840x2160@144, 0x0, 1.5
```

Restart hyprland.

Edit ~/.config/hypr/hyprland.conf:

```bash
exec-once = waybar
```

Restart hyprland.

