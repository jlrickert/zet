# Task: TrueNas Installation on ts140

Installing TrueNas on the [ts140](../653) after the [hardware upgrade](../784).

- OS Drive on the 1TB SSD.
- Using default 16GB swap
- A static IP address is called an _alias_.

  Best way to update was through the GUI. TUI is slight busted. Probably a localization issue.

## Storage setup

Using RAIDZ1 for now. Not recommended for larger drives as there is a high risk of data loss if you lose one drive. Need to wait for the new drive to arrive and there is a resilvering process that needs to happen.

I will use for now until I hit about the 1TB mark. Will buy a 4th drive (I still have room for 1 more) and move over to RAIDZ2.

```
sda (ZC1A8TYD)
sdc (ZC19EGH0)
sdd (ZC19B6Q5)
```