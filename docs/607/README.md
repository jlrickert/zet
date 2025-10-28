# Common network ranges used in private networks

Common private IPv4 ranges and typical default subnets used by platforms and
container networking. Use it as a quick reference when planning local networks
or avoiding address collisions.

## Subnets used by platforms and applications

Services that use [IPv4 private IP address ranges](../582)

These are common defaults and examples:

- Home router defaults
  - `192.168.0.0/24`
  - `192.168.1.0/24`
  - `192.168.2.0/24`
  - `10.0.0.0/24`

- Hyper-V: `192.168.137.0/24`

- VirtualBox
  - NAT: `10.0.2.0/24`
  - Host-only: `192.168.56.0/24`

- VMware: defaults vary by product and install. Many deployments use
  `192.168.x.0/24` host-only or NAT networks. Check your VMware network settings
  to confirm.

- Azure: commonly `10.0.0.0/16` or other `10.x.x.x/24` subnets you define

- AWS
  - VPC examples: `10.0.0.0/16`
  - Default EC2 VPC: `172.31.0.0/16`
  - You may also see `192.168.x.x/16` in some setups

- Google Cloud Platform (example)
  - GCP auto mode historically creates `10.x.x.0/20` subnets per region.
  - Example: `10.128.0.0/20` (varies by project and region)

- Docker
  - Default bridge: `172.17.0.0/16`
  - Overlay networks vary and are configurable

- Podman (default rootless network): `10.88.0.0/16`

- Kubernetes
  - Service CIDR (common default): `10.96.0.0/12`
  - Pod CIDR examples:
    - Flannel: `10.244.0.0/16`
    - Calico: often configured as `192.168.0.0/16` or a `10.x.x.x/16` range
    - Weave: `10.32.0.0/12`
  - CNI plugins and cluster installers can change these values. Always check
    cluster configuration.

- OpenShift
  - Service network (example): `172.30.0.0/16`
  - Pod networks vary by install

- Common private blocks referenced in setups
  - `10.0.0.0/8` (very large; many services use subnets inside this)
  - `172.16.0.0/12`
  - `192.168.0.0/16`

Note: many products let you change these defaults. Always verify runtime
configuration before assuming a specific subnet.

## IoT and guest network suggestions

Put IoT and guest devices on isolated VLANs or SSIDs and use subnets that are
unlikely to collide with typical defaults. Examples:

- Small IoT VLANs
  - `192.168.200.0/24`
  - `192.168.201.0/24`
  - `10.250.0.0/16` (if you prefer 10-space)
- Guest network examples
  - `192.168.150.0/24`
  - `10.251.0.0/16`

Recommended practices for IoT networks

- Use VLANs to separate IoT from trusted networks.
- Apply strict firewall rules so IoT devices cannot initiate traffic to
  sensitive subnets.
- Use DHCP reservations or static mappings for devices you must find easily.
- Use a local DNS suffix so devices are easier to locate, for example
  `iot.example.local`.
- Consider placing cameras, sensors, and smart plugs in separate subnets if you
  need different policies for each device class.

## Recommendations when choosing your own ranges

- Use /24 networks per VLAN for simplicity and predictability.
- Pick ranges that are unlikely to collide with remote networks you will VPN or
  connect to. Avoid very common defaults like `192.168.1.0/24` if you will
  establish many site-to-site or client VPNs.
- Prefer higher or uncommon `192.168.x.0/24` values such as `192.168.250.0/24`
  or `192.168.254.0/24` when possible.
- If you prefer `10.` space, pick a less used block such as `10.250.0.0/16`
  rather than `10.0.0.0/8`.
- Document your address plan. Keep a simple spreadsheet or text file that
  records each VLAN, subnet, gateway, DHCP range, and purpose.
- Reserve small blocks for infrastructure (DNS, DHCP, NTP, printers, VLAN
  gateways) and use DHCP reservations for servers and important devices.
- Check all remote networks and cloud VPCs you connect to. If overlap exists,
  plan for NAT or choose a different local range to avoid routing conflicts.
- Use IPv6 Unique Local Addresses for internal IPv6 if you adopt IPv6:
  `fd00::/8` for ULA space.
- Test before wide deployment. Bring up a test VLAN and verify routing, firewall
  rules, and VPN connectivity.

## Handling overlapping networks

If you discover an overlap after deployment:

- Change the local subnet if feasible.
- Use NAT on the VPN edge to translate overlapping private addresses.
- Use routing rules or split networking so only nonconflicting addresses are
  exchanged.
- Consider network address translation as a last resort due to added complexity.

## Quick checklist before assigning a new range

- Will this subnet be routed to other sites or cloud VPCs?
- Is this subnet likely to collide with common defaults?
- Is a VLAN or firewall rule required to isolate the devices?
- Are DHCP reservations needed for critical devices?
- Is the addressing plan documented and backed up?
