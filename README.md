# NixOS Configuration

Modern NixOS configuration using flakes for VirtualBox testing and T480 laptop.

## Structure

```
.
├─ flake.nix                           # Main flake configuration
├─ modules/
│  └─ common.nix                       # Shared configuration between hosts
└─ hosts/
   ├─ vbox/
   │  ├─ hardware-configuration.nix    # VirtualBox hardware config
   │  └─ host.nix                      # VirtualBox specific settings
   └─ t480/
      ├─ hardware-configuration.nix    # T480 hardware config
      └─ host.nix                      # T480 specific settings
```

## VirtualBox Installation Guide

### 1. VirtualBox Setup

1. **Create new virtual machine:**
   - Name: `NixOS-Test`
   - Type: `Linux`
   - Version: `Other Linux (64-bit)`
   - Memory: `2048 MB` (minimum)
   - Hard disk: `Create a virtual hard disk now`
   - Hard disk file type: `VDI`
   - Storage: `Dynamically allocated`
   - Size: `20 GB` (minimum)

2. **Virtual machine settings:**
   - Settings → System → Processor: `2 CPUs`
   - Settings → Display → Video Memory: `128 MB`
   - Settings → Storage: Attach NixOS minimal ISO to CD/DVD

### 2. NixOS Installation

1. **Boot from ISO:**
   - Start VM, boot from ISO
   - Login as `nixos` (no password)

2. **Internet connection (if needed):**
   ```bash
   # Test internet
   ping google.com
   
   # If not working, configure network
   sudo systemctl start wpa_supplicant
   ```

3. **Disk partitioning:**
   ```bash
   # Show disks
   lsblk
   
   # Partition disk (usually /dev/sda)
   sudo fdisk /dev/sda
   
   # Create GPT table: g
   # Create EFI partition (512M): n, 1, enter, +512M, t, 1
   # Create root partition (rest): n, 2, enter, enter
   # Save changes: w
   ```

4. **Format partitions:**
   ```bash
   # Format EFI partition
   sudo mkfs.fat -F 32 -n boot /dev/sda1
   
   # Format root partition
   sudo mkfs.ext4 -L nixos /dev/sda2
   ```

5. **Mount filesystems:**
   ```bash
   # Mount root
   sudo mount /dev/disk/by-label/nixos /mnt
   
   # Create boot directory and mount EFI
   sudo mkdir -p /mnt/boot
   sudo mount /dev/disk/by-label/boot /mnt/boot
   ```

6. **Generate configuration:**
   ```bash
   # Generate hardware config
   sudo nixos-generate-config --root /mnt
   ```

7. **Basic installation:**
   ```bash
   # Clone our configuration repository
   git clone https://github.com/buresmi7/nixos-config.git /mnt/etc/nixos-config
   
   # Use our install configuration
   sudo cp /mnt/etc/nixos/configuration.nix /mnt/etc/nixos/configuration.nix.backup
   sudo cp /mnt/etc/nixos-config/install-configuration.nix /mnt/etc/nixos/configuration.nix
   
   # Install NixOS
   sudo nixos-install
   
   # Set password for root
   # Set password for michal
   ```
   
   **Note:** If git is not available, run: `nix-shell -p git` first to temporarily make it available.

8. **Reboot:**
   ```bash
   sudo reboot
   ```

### 3. Using Our Configuration

1. **After reboot, login as michal**

2. **Clone our configuration:**
   ```bash
   # Install git if needed
   nix-shell -p git
   
   # Clone repository
   git clone git@github.com:buresmi7/nixos-config.git nixos-config
   cd nixos-config
   ```

3. **Copy hardware config:**
   ```bash
   sudo cp /etc/nixos/hardware-configuration.nix hosts/vbox/
   ```

4. **Apply our configuration:**
   ```bash
   # Enable flakes for current session
   export NIX_CONFIG="experimental-features = nix-command flakes"
   
   # Apply our config (which has flakes enabled)
   sudo nixos-rebuild switch --flake .#vbox
   ```

## Initial Setup

### 1. VirtualBox Testing (Alternative Method)

1. Install NixOS on VirtualBox
2. Copy the generated hardware configuration:
   ```bash
   sudo cp /etc/nixos/hardware-configuration.nix /path/to/nixos-config/hosts/vbox/
   ```
3. Clone this repository to your VirtualBox NixOS installation
4. Apply the configuration:
   ```bash
   sudo nixos-rebuild switch --flake .#vbox
   ```

### 2. T480 Laptop Setup

1. Boot from NixOS installer on your T480
2. Generate hardware configuration:
   ```bash
   nixos-generate-config --show-hardware-config > hardware-configuration.nix
   ```
3. Replace `hosts/t480/hardware-configuration.nix` with the generated content
4. Install NixOS and apply configuration:
   ```bash
   sudo nixos-rebuild switch --flake .#t480
   ```

## Usage

### Switching Configurations

**For VirtualBox:**
```bash
sudo nixos-rebuild switch --flake .#vbox
```

**For T480:**
```bash
sudo nixos-rebuild switch --flake .#t480
```

### Testing Changes

**Test without switching:**
```bash
sudo nixos-rebuild test --flake .#vbox
# or
sudo nixos-rebuild test --flake .#t480
```

**Build only (check for errors):**
```bash
nix build .#nixosConfigurations.vbox.config.system.build.toplevel
# or
nix build .#nixosConfigurations.t480.config.system.build.toplevel
```

### Updating System

**Update flake inputs:**
```bash
nix flake update
```

**Rebuild with updates:**
```bash
sudo nixos-rebuild switch --flake .#vbox --upgrade
```

## Common Commands

**Enter development shell:**
```bash
nix develop
```

**Check flake:**
```bash
nix flake check
```

**Show flake info:**
```bash
nix flake show
```

## User Configuration

- **Username**: `michal`
- **Default packages**: `git`, `mc` (Midnight Commander)
- **SSH**: Enabled with password authentication
- **Timezone**: Europe/Prague
- **Locale**: en_US.UTF-8 with Czech regional settings

## Host-Specific Features

### VirtualBox (`vbox`)
- VirtualBox guest additions
- GNOME desktop environment
- Auto-login for user `michal`
- X11 support

### T480 Laptop (`t480`)
- Power management with TLP
- Bluetooth support
- WiFi support via NetworkManager
- Touchpad support
- Firmware updates via fwupd
- Intel graphics acceleration

## Troubleshooting

**If rebuild fails:**
1. Check syntax: `nix flake check`
2. Verify hardware-configuration.nix is properly set up
3. Check logs: `journalctl -xe`

**Generate new hardware config:**
```bash
sudo nixos-generate-config --show-hardware-config > hosts/[hostname]/hardware-configuration.nix
```

## Development

To modify configurations:
1. Edit files in `modules/` for shared settings
2. Edit files in `hosts/[hostname]/` for host-specific settings
3. Test changes with `nixos-rebuild test`
4. Apply changes with `nixos-rebuild switch`

## Notes

- This configuration uses NixOS 24.05 (stable)
- Flakes are enabled system-wide
- Password-less sudo is enabled for wheel group users
- Firewall allows SSH (port 22)