# [x] Issue: EOL for 25.1 Opnsense

Ran into an issue on my [homelab](../578) where the path to upgrade form 25.1 to 25.7 is not available on my [opnsense](../1117) [router](../699).

## Context

- Current date 2025-08-23

## Description

> OPNsense 25.1 "Ultimate Unicorn" has reached its end of life. As such it will not receive any more updates, but the upgrade to the new 25.7 series is seamless and can be performed right here from the web GUI.

> Another method is to import and reinstall using a new installation image, which will retain your settings using "Import Configuration", then reformat the disk and apply a clean system using either "Install (ZFS)" or "Install (UFS)".

> You can also upgrade via console / SSH by using option 12 from the menu by typing "25.7" when prompted.

> Make sure to read the migration notes and account for possible breaking changes.

> Please backup your configuration, preview the new version via live image or in a virtual machine. If applicable, create VM snapshots or use the built-in snapshot feature available on ZFS installations. If all else fails, report back in the [forums][opnsense-forums] for assistance.

[opnsense-forums](https://forum.opnsense.org/)


## Solution

Just needed to wait longer before the update path was available.