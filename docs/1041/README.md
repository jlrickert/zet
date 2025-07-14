# Creating an [Ubuntu Server](../670) 24.04 for my [Homelab](../578)

- Created a base template for my [homelab](../578).

## Configuration

- General
  - **name:** ubuntu-2404-lts-v1
- OS
  - **iso:** ubuntu-24.04.2-live-server-amd64.iso
- System
  - **BIOS:** OVMF
  - **EFI Storage:** local-lvm
  - **Qemu Agent:** [x]
  - **SCSI Controller:** VirtIO SCSI single
- Disk
  - **Bus/Device:** SCSI
  - **Disk Size:** 32G
  - **Cache:** No Cache
  - **Discard:** [x] Running on local nvme drive
- CPU
  - 2 cores
- MEMORY
  - 2048 MiB

> [!NOTE]
> 
> AI Garbage below

This note outlines the steps for setting up a new [Ubuntu Server 24.04](../670) instance within my [homelab](../578) environment, from initial installation to essential post-setup configurations. It aims to provide a quick start guide for deploying a reliable server ready for various [homelab projects](../578), from hosting services to managing infrastructure.

## Prerequisites

Before beginning, ensure you have the following:

- **Ubuntu Server 24.04 LTS (Noble Numbat) ISO:** Downloadable from the official Ubuntu website ([Ubuntu Server Download][ubuntu-dl]).
- **Bootable USB Drive or VM Environment:** For physical hardware, use tools like Rufus or Etcher to create a bootable USB. For virtualization, consider [Proxmox](../635), VirtualBox ([VirtualBox on apple silicon](../576)), or UTM ([VM setup on apple silicon with UTM][utm-vm-setup]).
- **Network Cable:** For a wired connection, which is recommended for servers.
- **SSH Client:** For remote access after installation (e.g., OpenSSH on Linux/macOS, PuTTY on Windows).

## Installation Steps

1.  **Boot from Installation Media:**

    - Insert the bootable USB or mount the ISO in your virtual machine.
    - Power on the machine and boot from the selected media.

2.  **Language and Keyboard Layout:**

    - Select your preferred language.
    - Choose the correct keyboard layout.

3.  **Network Configuration:**

    - The installer will attempt to acquire an IP address via DHCP. For a [homelab](../578) server, it's highly recommended to configure a static IP address. Refer to [Networking in Ubuntu 24.04](../872) for detailed guidance on static IP setup. This ensures your server's address remains consistent for easy access and service configuration.
    - Consider setting a descriptive hostname during this step.

4.  **Installer Updates:**

    - The installer may prompt to update itself. Proceed with the update for the latest installer features and bug fixes.

5.  **Storage Configuration:**

    - Choose "Use an entire disk" for simplicity, or "Custom storage layout" for advanced partitioning. For most [homelab](../578) setups, using the entire disk is sufficient.
    - Ensure to confirm the proposed storage layout before proceeding, as this will erase all data on the selected disk.

6.  **Profile Setup:**

    - Enter your name, the server's name, and create a strong username and password. This will be your primary administrative user.

7.  **SSH Setup:**

    - Crucially, select "Install OpenSSH server" to enable remote access.
    - You can optionally import public SSH keys from GitHub or Launchpad for immediate key-based authentication. If not, you'll set this up manually post-installation.

8.  **Featured Snaps (Optional):**

    - Review the list of recommended snaps. You can skip this for a minimal installation, as additional software can be installed later via [Package management in Ubuntu](../571) or [Docker](../16).

9.  **Installation Process:**

    - The installer will now proceed with installing Ubuntu Server. This may take some time depending on your hardware.

10. **Reboot:**
    - Once the installation is complete, remove the installation media and reboot the server.

## Post-Installation Configuration

After the first boot, log in with the user created during installation.

1.  **System Updates:**

    - Always start by updating your package lists and upgrading installed packages:
      ```bash
      sudo apt update
      sudo apt upgrade -y
      ```

2.  **Firewall (`ufw`):**

    - Enable the Uncomplicated Firewall (`ufw`) to secure your server. Allow SSH access and any other necessary services:
      ```bash
      sudo ufw allow ssh
      # Example: if you plan to run a web server
      # sudo ufw allow http
      # sudo ufw allow https
      sudo ufw enable
      sudo ufw status
      ```

3.  **SSH Key Authentication (if not set up during install):**

    - For enhanced security, disable password authentication for SSH and rely solely on SSH keys.
      - Copy your public key to the server: `ssh-copy-id username@your_server_ip`
      - Edit `/etc/ssh/sshd_config` to set `PasswordAuthentication no` and `PermitRootLogin no`.
      - Restart SSH service: `sudo systemctl restart sshd`.

4.  **Time Synchronization (NTP):**
    - Ubuntu generally uses `systemd-timesyncd` for NTP. Verify its status if needed:
      ```bash
      timedatectl status
      ```

## Common [Homelab](../578) Use Cases

Your new Ubuntu server is a versatile foundation for many [homelab projects](../578):

- **Containerization:** Install [Docker](../16) to easily deploy applications in isolated containers.
- **Network Services:** Set up [Pi-Hole](../662) for network-wide ad blocking and DNS caching, or configure [WireGuard topologies](../573) for secure remote access ([Road Warrior WireGuard VPN setup on OPNSense](../787)).
- **File Storage/Cloud:** Deploy [Nextcloud](../785) for a personal cloud storage solution.
- **Virtualization (Nested):** If running on a powerful machine, you could install another hypervisor like [Proxmox](../635) to manage more VMs (though typically Proxmox would be the base OS).

[ubuntu-dl]: https://ubuntu.com/download/server
[utm-vm-setup]: ../22
[ubuntu-networking]: ../872
