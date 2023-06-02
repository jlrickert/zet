# Install flutter on macOS with apple silicon

Run the script to install flutter

```bash
mkdir -p ~/.local/share
cd "$(mktemp -d)" || exit 1
curl -fsSL -O https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.10.2-stable.zip
unzip flutter_macos_arm64_3.10.2-stable.zip -d ~/.local/share
```

The android toolchain needs to be setup. The easiest way to do this is
to install [android studio] and let it handle installation. Download it
from there website. Once android studio is installed run it and use
android studio setup wizard. See flutters [docs] for trouble shooting if
running `flutter doctor` doesn't see the android tool chain

To allow development on apple xcode and CocoaPods needs to be setup. Go
to apples website to [download] xcode. This requires some apple account
shenanigans (haven't done this step). Once installed run the following:

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

[download]: https://developer.apple.com/xcode/download/
[android studio]: https://developer.android.com/studio/index.html
[docs]: https://docs.flutter.dev/get-started/install/macos#android-setup

See also:

- [Install with curl](../101)

Meta:

    tags: #programming #macOS
