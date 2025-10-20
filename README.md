# NixOS Configuration

Modular NixOS configuration using Flakes and Disko.

## Installation

### ⚠️ Important

Disko **must run BEFORE installation**. Do NOT install from Live CD first.

### VirtualBox

1. **Create VM:**
   - 2GB RAM minimum
   - 20GB disk
   - **Enable EFI** in System settings

2. **Boot NixOS Minimal ISO:**
   ```bash
   nix-shell -p git
   git clone https://github.com/buresmi7/nixos-config.git
   cd nixos-config
   ```

3. **Format disk with Disko:**
   ```bash
   sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./hosts/vbox/disko.nix
   ```

4. **Install:**
   ```bash
   sudo nixos-install --flake .#vbox
   sudo reboot
   ```

### ThinkPad T480

1. **Boot from NixOS Minimal ISO**

2. **Clone and format:**
   ```bash
   nix-shell -p git
   git clone https://github.com/buresmi7/nixos-config.git
   cd nixos-config
   
   # Verify device name (should be /dev/nvme0n1)
   lsblk
   
   # Format disk
   sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./hosts/t480/disko.nix
   ```

3. **Install:**
   ```bash
   sudo nixos-install --flake .#t480
   sudo reboot
   ```

## Usage

**First Login:**
- Username: `michal`
- Password: `nixos` (initial password)

**Change password after first login:**
```bash
passwd
```

**Rebuild:**
```bash
sudo nixos-rebuild switch --flake .#vbox  # or .#t480
```

**Update:**
```bash
nix flake update
sudo nixos-rebuild switch --flake .#vbox --upgrade
```

## Troubleshooting

**Cannot login after installation:**
- Default username: `michal`
- Default password: `nixos`
- Change password immediately after first login using `passwd`

**Error: "waiting for device disk-main-root"**
- Disko was not run before installation
- Solution: Reinstall using the steps above

**WiFi on T480:**
```bash
sudo nmtui