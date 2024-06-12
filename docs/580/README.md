# Think Server T140 hardware dump

26 decibals

- [specifiation](https://lenovopress.lenovo.com/lp0034.pdf)

## Memory upgrade

## Hardware dump

```
think-server
    description: Tower Computer
    product: ThinkServer TS140 (LENOVO_PN_ThinkServer TS140)
    vendor: LENOVO
    version: 70A4000HUX
    serial: MJ0377NU
    width: 64 bits
    capabilities: smbios-2.8 dmi-2.8 smp vsyscall32
    configuration: administrator_password=disabled boot=normal chassis=tower family=To be filled by O.E.M. keyboard_password=enabled power-on_password=disabled sku=LENOVO_PN_ThinkServer TS140 uuid=9a133295-d384-e511-b046-6c0b846a2c32
  *-core
       description: Motherboard
       product: ThinkServer TS140
       vendor: LENOVO
       physical id: 0
       version: Not Defined
       slot: To be filled by O.E.M.
     *-firmware
          description: BIOS
          vendor: LENOVO
          physical id: 0
          version: FBKTB3AUS
          date: 06/16/2015
          size: 64KiB
          capacity: 6656KiB
          capabilities: pci upgrade shadowing cdboot bootselect socketedrom edd int13floppy1200 int13floppy720 int13floppy2880 int5printscreen int9keyboard int14serial int17printer acpi usb biosbootspecification uefi
     *-cpu
          description: CPU
          product: Intel(R) Xeon(R) CPU E3-1246 v3 @ 3.50GHz
          vendor: Intel Corp.
          physical id: 3d
          bus info: cpu@0
          version: 6.60.3
          slot: SOCKET 0
          size: 2494MHz
          capacity: 3900MHz
          width: 64 bits
          clock: 100MHz
          capabilities: lm fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp x86-64 constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts md_clear flush_l1d cpufreq
          configuration: cores=4 enabledcores=4 microcode=40 threads=8
        *-cache:0
             description: L2 cache
             physical id: 3e
             slot: CPU Internal L2
             size: 1MiB
             capacity: 1MiB
             capabilities: internal write-back unified
             configuration: level=2
        *-cache:1
             description: L1 cache
             physical id: 3f
             slot: CPU Internal L1
             size: 256KiB
             capacity: 256KiB
             capabilities: internal write-back
             configuration: level=1
        *-cache:2
             description: L3 cache
             physical id: 40
             slot: CPU Internal L3
             size: 8MiB
             capacity: 8MiB
             capabilities: internal write-back unified
             configuration: level=3
     *-memory
          description: System Memory
          physical id: 41
          slot: System board or motherboard
          size: 8GiB
          capabilities: ecc
          configuration: errordetection=ecc
        *-bank:0
             description: DIMM [empty]
             product: [Empty]
             vendor: [Empty]
             physical id: 0
             serial: [Empty]
             slot: DIMM1
        *-bank:1
             description: DIMM DDR3 Synchronous 1600 MHz (0.6 ns)
             product: HMT451U7BFR8A-PB
             vendor: Hynix/Hyundai
             physical id: 1
             serial: 7115E909
             slot: DIMM2
             size: 4GiB
             width: 64 bits
             clock: 1600MHz (0.6ns)
        *-bank:2
             description: DIMM [empty]
             product: [Empty]
             vendor: [Empty]
             physical id: 2
             serial: [Empty]
             slot: DIMM3
        *-bank:3
             description: DIMM DDR3 Synchronous 1600 MHz (0.6 ns)
             product: HMT451U7BFR8A-PB
             vendor: Hynix/Hyundai
             physical id: 3
             serial: 707AD97E
             slot: DIMM4
             size: 4GiB
             width: 64 bits
             clock: 1600MHz (0.6ns)
     *-pci
          description: Host bridge
          product: Xeon E3-1200 v3 Processor DRAM Controller
          vendor: Intel Corporation
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 06
          width: 32 bits
          clock: 33MHz
          configuration: driver=ie31200_edac
          resources: irq:0
        *-display
             description: VGA compatible controller
             product: Xeon E3-1200 v3 Processor Integrated Graphics Controller
             vendor: Intel Corporation
             physical id: 2
             bus info: pci@0000:00:02.0
             version: 06
             width: 64 bits
             clock: 33MHz
             capabilities: msi pm vga_controller bus_master cap_list rom
             configuration: driver=i915 latency=0
             resources: irq:31 memory:f7800000-f7bfffff memory:e0000000-efffffff ioport:f000(size=64) memory:c0000-dffff
        *-multimedia:0
             description: Audio device
             product: Xeon E3-1200 v3/4th Gen Core Processor HD Audio Controller
             vendor: Intel Corporation
             physical id: 3
             bus info: pci@0000:00:03.0
             logical name: card0
             logical name: /dev/snd/controlC0
             logical name: /dev/snd/hwC0D0
             logical name: /dev/snd/pcmC0D10p
             logical name: /dev/snd/pcmC0D3p
             logical name: /dev/snd/pcmC0D7p
             logical name: /dev/snd/pcmC0D8p
             logical name: /dev/snd/pcmC0D9p
             version: 06
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi pciexpress bus_master cap_list
             configuration: driver=snd_hda_intel latency=0
             resources: irq:33 memory:f7c34000-f7c37fff
           *-input:0
                product: HDA Intel HDMI HDMI/DP,pcm=3
                physical id: 0
                logical name: input3
                logical name: /dev/input/event3
           *-input:1
                product: HDA Intel HDMI HDMI/DP,pcm=7
                physical id: 1
                logical name: input4
                logical name: /dev/input/event4
           *-input:2
                product: HDA Intel HDMI HDMI/DP,pcm=8
                physical id: 2
                logical name: input5
                logical name: /dev/input/event5
           *-input:3
                product: HDA Intel HDMI HDMI/DP,pcm=9
                physical id: 3
                logical name: input6
                logical name: /dev/input/event6
           *-input:4
                product: HDA Intel HDMI HDMI/DP,pcm=10
                physical id: 4
                logical name: input7
                logical name: /dev/input/event7
        *-usb:0
             description: USB controller
             product: 8 Series/C220 Series Chipset Family USB xHCI
             vendor: Intel Corporation
             physical id: 14
             bus info: pci@0000:00:14.0
             version: 04
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi xhci bus_master cap_list
             configuration: driver=xhci_hcd latency=0
             resources: irq:29 memory:f7c20000-f7c2ffff
           *-usbhost:0
                product: xHCI Host Controller
                vendor: Linux 5.15.0-60-generic xhci-hcd
                physical id: 0
                bus info: usb@3
                logical name: usb3
                version: 5.15
                capabilities: usb-2.00
                configuration: driver=hub slots=15 speed=480Mbit/s
           *-usbhost:1
                product: xHCI Host Controller
                vendor: Linux 5.15.0-60-generic xhci-hcd
                physical id: 1
                bus info: usb@4
                logical name: usb4
                version: 5.15
                capabilities: usb-3.00
                configuration: driver=hub slots=6 speed=5000Mbit/s
        *-communication:0
             description: Communication controller
             product: 8 Series/C220 Series Chipset Family MEI Controller #1
             vendor: Intel Corporation
             physical id: 16
             bus info: pci@0000:00:16.0
             version: 04
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list
             configuration: driver=mei_me latency=0
             resources: irq:32 memory:f7c40000-f7c4000f
        *-communication:1
             description: Serial controller
             product: 8 Series/C220 Series Chipset Family KT Controller
             vendor: Intel Corporation
             physical id: 16.3
             bus info: pci@0000:00:16.3
             version: 04
             width: 32 bits
             clock: 66MHz
             capabilities: pm msi 16550 cap_list
             configuration: driver=serial latency=0
             resources: irq:19 ioport:f0e0(size=8) memory:f7c3e000-f7c3efff
        *-network
             description: Ethernet interface
             product: Ethernet Connection I217-LM
             vendor: Intel Corporation
             physical id: 19
             bus info: pci@0000:00:19.0
             logical name: eno1
             version: 04
             serial: 6c:0b:84:6a:2c:32
             size: 1Gbit/s
             capacity: 1Gbit/s
             width: 32 bits
             clock: 33MHz
             capabilities: pm msi bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
             configuration: autonegotiation=on broadcast=yes driver=e1000e driverversion=5.15.0-60-generic duplex=full firmware=0.13-4 ip=192.168.1.11 latency=0 link=yes multicast=yes port=twisted pair speed=1Gbit/s
             resources: irq:28 memory:f7c00000-f7c1ffff memory:f7c3d000-f7c3dfff ioport:f080(size=32)
        *-usb:1
             description: USB controller
             product: 8 Series/C220 Series Chipset Family USB EHCI #2
             vendor: Intel Corporation
             physical id: 1a
             bus info: pci@0000:00:1a.0
             version: 04
             width: 32 bits
             clock: 33MHz
             capabilities: pm debug ehci bus_master cap_list
             configuration: driver=ehci-pci latency=0
             resources: irq:17 memory:f7c3c000-f7c3c3ff
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 5.15.0-60-generic ehci_hcd
                physical id: 1
                bus info: usb@1
                logical name: usb1
                version: 5.15
                capabilities: usb-2.00
                configuration: driver=hub slots=3 speed=480Mbit/s
              *-usb
                   description: USB hub
                   product: Integrated Rate Matching Hub
                   vendor: Intel Corp.
                   physical id: 1
                   bus info: usb@1:1
                   version: 0.04
                   capabilities: usb-2.00
                   configuration: driver=hub slots=6 speed=480Mbit/s
        *-multimedia:1
             description: Audio device
             product: 8 Series/C220 Series Chipset High Definition Audio Controller
             vendor: Intel Corporation
             physical id: 1b
             bus info: pci@0000:00:1b.0
             logical name: card1
             logical name: /dev/snd/controlC1
             logical name: /dev/snd/hwC1D2
             logical name: /dev/snd/pcmC1D0c
             logical name: /dev/snd/pcmC1D0p
             logical name: /dev/snd/pcmC1D2c
             version: 04
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi pciexpress bus_master cap_list
             configuration: driver=snd_hda_intel latency=0
             resources: irq:34 memory:f7c30000-f7c33fff
           *-input:0
                product: HDA Intel PCH Line Out
                physical id: 0
                logical name: input10
                logical name: /dev/input/event10
           *-input:1
                product: HDA Intel PCH Mic
                physical id: 1
                logical name: input8
                logical name: /dev/input/event8
           *-input:2
                product: HDA Intel PCH Line
                physical id: 2
                logical name: input9
                logical name: /dev/input/event9
        *-pci:0
             description: PCI bridge
             product: 8 Series/C220 Series Chipset Family PCI Express Root Port #1
             vendor: Intel Corporation
             physical id: 1c
             bus info: pci@0000:00:1c.0
             version: d4
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:26
        *-pci:1
             description: PCI bridge
             product: 8 Series/C220 Series Chipset Family PCI Express Root Port #4
             vendor: Intel Corporation
             physical id: 1c.3
             bus info: pci@0000:00:1c.3
             version: d4
             width: 32 bits
             clock: 33MHz
             capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:27
           *-pci
                description: PCI bridge
                product: IT8893E PCIe to PCI Bridge
                vendor: Integrated Technology Express, Inc.
                physical id: 0
                bus info: pci@0000:02:00.0
                version: 41
                width: 32 bits
                clock: 33MHz
                capabilities: pci pm subtractive_decode bus_master cap_list
        *-usb:2
             description: USB controller
             product: 8 Series/C220 Series Chipset Family USB EHCI #1
             vendor: Intel Corporation
             physical id: 1d
             bus info: pci@0000:00:1d.0
             version: 04
             width: 32 bits
             clock: 33MHz
             capabilities: pm debug ehci bus_master cap_list
             configuration: driver=ehci-pci latency=0
             resources: irq:23 memory:f7c3b000-f7c3b3ff
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 5.15.0-60-generic ehci_hcd
                physical id: 1
                bus info: usb@2
                logical name: usb2
                version: 5.15
                capabilities: usb-2.00
                configuration: driver=hub slots=3 speed=480Mbit/s
              *-usb
                   description: USB hub
                   product: Integrated Rate Matching Hub
                   vendor: Intel Corp.
                   physical id: 1
                   bus info: usb@2:1
                   version: 0.04
                   capabilities: usb-2.00
                   configuration: driver=hub slots=8 speed=480Mbit/s
        *-isa
             description: ISA bridge
             product: C226 Series Chipset Family Server Advanced SKU LPC Controller
             vendor: Intel Corporation
             physical id: 1f
             bus info: pci@0000:00:1f.0
             version: 04
             width: 32 bits
             clock: 33MHz
             capabilities: isa bus_master cap_list
             configuration: driver=lpc_ich latency=0
             resources: irq:0
           *-pnp00:00
                product: PnP device PNP0c02
                physical id: 0
                capabilities: pnp
                configuration: driver=system
           *-pnp00:01
                product: PnP device PNP0b00
                physical id: 1
                capabilities: pnp
                configuration: driver=rtc_cmos
           *-pnp00:02
                product: PnP device INT3f0d
                physical id: 2
                capabilities: pnp
                configuration: driver=system
           *-pnp00:03
                product: PnP device PNP0c02
                physical id: 3
                capabilities: pnp
                configuration: driver=system
           *-pnp00:04
                product: PnP device PNP0c02
                physical id: 4
                capabilities: pnp
                configuration: driver=system
           *-pnp00:05
                product: PnP device PNP0c31
                physical id: 5
                capabilities: pnp
                configuration: driver=tpm_tis
           *-pnp00:06
                product: PnP device PNP0c02
                physical id: 6
                capabilities: pnp
                configuration: driver=system
        *-sata
             description: SATA controller
             product: 8 Series/C220 Series Chipset Family 6-port SATA Controller 1 [AHCI mode]
             vendor: Intel Corporation
             physical id: 1f.2
             bus info: pci@0000:00:1f.2
             logical name: scsi0
             logical name: scsi3
             logical name: scsi4
             version: 04
             width: 32 bits
             clock: 66MHz
             capabilities: sata msi pm ahci_1.0 bus_master cap_list emulated
             configuration: driver=ahci latency=0
             resources: irq:30 ioport:f0d0(size=8) ioport:f0c0(size=4) ioport:f0b0(size=8) ioport:f0a0(size=4) ioport:f060(size=32) memory:f7c3a000-f7c3a7ff
           *-disk:0
                description: ATA Disk
                product: WDC WD30EZRX-19D
                vendor: Western Digital
                physical id: 0
                bus info: scsi@0:0.0.0
                logical name: /dev/sda
                version: 0A81
                serial: WD-WMC4N0K2P23R
                size: 2794GiB (3TB)
                capabilities: gpt-1.00 partitioned partitioned:gpt
                configuration: ansiversion=5 guid=8aa6630a-9dd4-4647-bd50-6b4ee44219fa logicalsectorsize=512 sectorsize=4096
              *-volume:0 UNCLAIMED
                   description: Windows FAT volume
                   vendor: mkfs.fat
                   physical id: 1
                   bus info: scsi@0:0.0.0,1
                   version: FAT32
                   serial: 5f82-c0bd
                   size: 1073MiB
                   capacity: 1074MiB
                   capabilities: boot fat initialized
                   configuration: FATs=2 filesystem=fat
              *-volume:1
                   description: EXT4 volume
                   vendor: Linux
                   physical id: 2
                   bus info: scsi@0:0.0.0,2
                   logical name: /dev/sda2
                   logical name: /boot
                   version: 1.0
                   serial: d80bc9f1-7bd5-4ee2-8aee-361a398386f9
                   size: 2GiB
                   capabilities: journaled extended_attributes large_files huge_files dir_nlink recover 64bit extents ext4 ext2 initialized
                   configuration: created=2023-02-18 03:28:58 filesystem=ext4 lastmountpoint=/boot modified=2023-03-08 20:09:56 mount.fstype=ext4 mount.options=rw,relatime mounted=2023-03-08 20:09:56 state=mounted
              *-volume:2
                   description: EFI partition
                   physical id: 3
                   bus info: scsi@0:0.0.0,3
                   logical name: /dev/sda3
                   serial: zv2z1U-n2AB-yYX6-cND8-qsaz-Yduf-HINCjS
                   size: 2791GiB
                   capacity: 2791GiB
                   capabilities: lvm2
           *-disk:1
                description: ATA Disk
                product: Hitachi HTS54757
                vendor: Hitachi
                physical id: 1
                bus info: scsi@3:0.0.0
                logical name: /dev/sdb
                version: A50A
                serial: J1140021GBN27K
                size: 698GiB (750GB)
                capabilities: gpt-1.00 partitioned partitioned:gpt
                configuration: ansiversion=5 guid=96bb7bcb-660e-4099-89a2-a107a5ac57c0 logicalsectorsize=512 sectorsize=4096
              *-volume:0
                   description: EFI partition
                   physical id: 1
                   bus info: scsi@3:0.0.0,1
                   logical name: /dev/sdb1
                   serial: 322385ea-974a-4b6e-84c4-2142699f4aae
                   capacity: 1006KiB
              *-volume:1
                   description: Windows FAT volume
                   vendor: mkfs.fat
                   physical id: 2
                   bus info: scsi@3:0.0.0,2
                   logical name: /dev/sdb2
                   version: FAT32
                   serial: 56c6-1a79
                   size: 510MiB
                   capacity: 511MiB
                   capabilities: boot fat initialized
                   configuration: FATs=2 filesystem=fat
              *-volume:2
                   description: LVM Physical Volume
                   vendor: Linux
                   physical id: 3
                   bus info: scsi@3:0.0.0,3
                   logical name: /dev/sdb3
                   serial: cckSOB-mLGB-Ccu1-1SbO-ho3b-odIb-nEVaoa
                   size: 698GiB
                   capabilities: multi lvm2
           *-cdrom
                description: DVD reader
                product: DVDROM DH60N
                vendor: HL-DT-ST
                physical id: 0.0.0
                bus info: scsi@4:0.0.0
                logical name: /dev/cdrom
                logical name: /dev/sr0
                version: 1.00
                capabilities: removable audio dvd
                configuration: ansiversion=5 status=nodisc
        *-serial
             description: SMBus
             product: 8 Series/C220 Series Chipset Family SMBus Controller
             vendor: Intel Corporation
             physical id: 1f.3
             bus info: pci@0000:00:1f.3
             version: 04
             width: 64 bits
             clock: 33MHz
             configuration: driver=i801_smbus latency=0
             resources: irq:18 memory:f7c39000-f7c390ff ioport:580(size=32)
  *-input:0
       product: Power Button
       physical id: 1
       logical name: input0
       logical name: /dev/input/event0
       capabilities: platform
  *-input:1
       product: Power Button
       physical id: 2
       logical name: input1
       logical name: /dev/input/event1
       capabilities: platform
  *-input:2
       product: Video Bus
       physical id: 3
       logical name: input2
       logical name: /dev/input/event2
       capabilities: platform
```

