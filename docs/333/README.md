# Flutter experiments

- How to lookup a device id

  Running `flutter devices` gives a device id

- Run a flutter app in debug mode for my samsung phone

  Plugging in my phone and giving it access lets vscode see the phone. From there I can select to run apps in debug mode.

- Run a flutter app in debug mode on a simulated iPhone

  Run `open -a simulator` and run from VSCode.

- Run app in debug mode with CLI

  WIP

- Building a release for android

  Run `flutter build apk`. This will generate a release candidate in `build/app/outputs/apk/release/app-release.apk`. A trick to get on an android device is to cd into the directory of the apk and then running `python3 -m http.server`. The IP address can be found using `ifconfig`. Usually, it is `ifconfig en0` on my mac.

- Building a release candidate for the web

  Run `flutter build web`. Then serve the contents of `build/app/web`.
