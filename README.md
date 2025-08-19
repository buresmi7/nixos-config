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

## Initial Setup

### 1. VirtualBox Testing

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