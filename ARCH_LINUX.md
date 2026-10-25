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

## SSH Agent Setup — Arch Linux + KDE Plasma 6

Configure OpenSSH with systemd, KDE's graphical passphrase prompt, and KWallet.

### Prerequisites

```bash
sudo pacman -S ksshaskpass kwallet
```

### 1. Enable the SSH agent socket

```bash
systemctl --user enable --now ssh-agent.socket
```

Set `SSH_AUTH_SOCK` in `~/.config/.zshrc` (not needed if you use this repository):

```bash
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
```

The socket is located at `$XDG_RUNTIME_DIR/ssh-agent.socket`.

Verify the agent:

```bash
ssh-add -l
```

### 2. Configure KDE Askpass

Create `~/.config/environment.d/ssh_askpass.conf`:

```ini
SSH_ASKPASS=/usr/bin/ksshaskpass
SSH_ASKPASS_REQUIRE=prefer
```

Log out of Plasma and log back in to apply the environment variables.

### 3. Automatically load multiple SSH keys

Create `~/.config/systemd/user/ssh-add-key.service` and replace `KEY_ONE` and `KEY_TWO`
with your actual private key filenames. Do not use the `.pub` files.

```ini
[Unit]
Description=Load SSH identities into ssh-agent
Requires=ssh-agent.socket
After=ssh-agent.socket

[Service]
Type=oneshot
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
ExecStart=/usr/bin/ssh-add %h/.ssh/KEY_ONE %h/.ssh/KEY_TWO
RemainAfterExit=yes

[Install]
WantedBy=default.target
```

Enable the service:

```bash
systemctl --user daemon-reload
systemctl --user enable --now ssh-add-key.service
```

### 4. Verify loaded identities

```bash
SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket" ssh-add -l
```

Both key fingerprints should appear.

To load keys manually:

```bash
ssh-add ~/.ssh/KEY_ONE ~/.ssh/KEY_TWO
```

### 5. Automatically add keys when used

Add to `~/.ssh/config`:

```sshconfig
Host *
    AddKeysToAgent yes
```

This instructs SSH to add identities to the agent when used.

### 6. KWallet passphrase storage

The SSH agent holds loaded identities, while KWallet can store passphrases. `ksshaskpass` provides the graphical passphrase prompt.

For a workflow similar to macOS Keychain:

- Configure KWallet to unlock during login if desired.
- Use the KWallet integration supported by your installed `ksshaskpass` version.
- Select the remember-password option if offered.
- Log out and back into Plasma to verify whether passphrases persist.

**Note:** Loading keys automatically does not guarantee that passphrases are stored persistently in KWallet. Verify this after a fresh login.

### Troubleshooting

**Agent has no identities**

```bash
ssh-add -l
ssh-add ~/.ssh/KEY_ONE ~/.ssh/KEY_TWO
```

**Agent connection failed**

```bash
echo "$SSH_AUTH_SOCK"
systemctl --user status ssh-agent.socket --no-pager
ls -l "$XDG_RUNTIME_DIR/ssh-agent.socket"
```

**Key file not found**

```bash
ls -la ~/.ssh
```

Update the service's `ExecStart` line to use the correct private key paths.

**Inspect service logs**

```bash
journalctl --user -u ssh-add-key.service -b -n 50 --no-pager
```

### Useful commands

| Task | Command |
|---|---|
| Check agent socket | `systemctl --user status ssh-agent.socket` |
| List loaded keys | `ssh-add -l` |
| Remove all loaded keys | `ssh-add -D` |
| Restart key-loading service | `systemctl --user restart ssh-add-key.service` |
| View service logs | `journalctl --user -u ssh-add-key.service -b` |

### Security

- Never commit private SSH keys or passphrases to your dotfiles repository.
- Keep private key files accessible only to your user.
- Protect KWallet with a strong password.
- Use placeholders for machine-specific key filenames in documentation.
