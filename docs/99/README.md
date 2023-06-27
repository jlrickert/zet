# Fedora workstation setup

Installed fedora workstation. This comes with gnome using wayland.

## i3 gaps exploration

Ran the following to install i3
`sudo dnf install --allowerasing i3-gaps`

This installs the following:

      dex-autostart-0.9.0-7.fc38.noarch                    dmenu-5.2-2.fc38.x86_64                              i3-4.22-4.fc38.x86_64
      i3-config-4.22-4.fc38.noarch                         i3lock-2.14.1-3.fc38.x86_64                          i3status-2.14-4.fc38.x86_64
      i3status-config-2.14-4.fc38.noarch                   libappindicator-gtk3-12.10.1-1.fc38.x86_64           libconfuse-3.3-8.fc38.x86_64
      libdbusmenu-16.04.0-21.fc38.x86_64                   libdbusmenu-gtk3-16.04.0-21.fc38.x86_64              libptytty-2.0-5.fc38.x86_64
      network-manager-applet-1.30.0-3.fc38.x86_64          perl-AnyEvent-7.17-14.fc38.x86_64                    perl-AnyEvent-I3-0.17-19.fc38.noarch
      perl-Filter-2:1.64-2.fc38.x86_64                     perl-Guard-1.023-26.fc38.x86_64                      perl-JSON-XS-1:4.03-9.fc38.x86_64
      perl-Sys-Syslog-0.36-491.fc38.x86_64                 perl-Task-Weaken-1.06-16.fc38.noarch                 perl-Time-HiRes-4:1.9770-490.fc38.x86_64
      perl-Types-Serialiser-1.01-8.fc38.noarch             perl-Unicode-Normalize-1.31-490.fc38.x86_64          perl-common-sense-3.7.5-11.fc38.x86_64
      perl-encoding-4:3.00-493.fc38.x86_64                 perl-open-1.13-495.fc38.noarch                       rxvt-unicode-9.31-2.fc38.x86_64
      xcb-util-cursor-0.1.4-2.fc38.x86_64                  xcb-util-xrm-1.3-11.fc38.x86_64                      xorg-x11-fonts-misc-7.5-35.fc38.noarch

Ran the following to install i3
`sudo dnf install --allowerasing feh thunar dunst i3-blocks rofi arandr`

## sway exploration

`sway` is a drop in replacemnt for i3-gaps but on wayland. This uses
some different utilities than what is found with

## Arch setup

Packages install on my arch system

-   rofi (dmenu replacement)

[EndeavourOS
repo](https://github.com/endeavouros-team/endeavouros-i3wm-setup)

## Flutter Experiment

This needs to be somewhere in your dotfiles

``` bash
export ANDROID_SDK_ROOT="$HOME/.local/share/android"
PATH="$HOME/.local/share/flutter/bin:$PATH"
PATH="$ANDROID_SDK_ROOT/cmdline-tools/bin:$PATH"
```

``` bash
sudo dnf install clang cmake ninja-build gtk3-devel
curl -fsSL -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.7.12-stable.tar.xz
tar xf flutter_linux_3.7.12-stable.tar.xz
mv flutter "$HOME/.local/share/flutter"
flutter config --no-analytics
flutter precache
curl -fsSL -O https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
unzip commandlinetools-linux-9477386_latest.zip
mkdir -p "$HOME/.local/share/android"
mv cmdline-tools "$HOME/.local/share/android/cmdline-tools"
mkdir "$HOME/.local/share/cmdline-tools/latest"
flutter config --android-studio-dir=/opt/android-studio
dart --disable-analytics sdkmanager "platform-tools" "platforms;android-33" sdkmanager "system-images;android-30;default;x86_64"
sdkmanager "platform-tools"
sdkmanager "build-tools;27.0.3"
sdkmanager "platforms;android-32"
sdkmanager emulator
```
