# Creating a time machine backup on TrueNAS

Wanted to backup my mac on my [TrueNAS](../676) [server](../563) in my [homelab](../578) as well as on my backup external HDD.

Steps to reproduce:

- Enable **Apple SMB2/3 Protocol Extensions**

  This is fund under **Shares**. Configure SMB shares to enable the extension in the modal that pops up on the right of the screen.

- Add SMB dataset

  Found under **Datasets** create a **SMB** share. I named it `time-machine` - may be too generic as I may want to backup multiple devices to it. Problem for later. Set the purpose to **Multi-user time machine** I also set a quota of 4 TiB.

- Mount smb on [mac](../583) (`smb:truenas.int.jlrickert.me/time-machine`).
- Add the time machine through the **Time Machine** in **Settings**