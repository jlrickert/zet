# How to manually install a package from the AUR

To install packages from the AUR this this is the steps that I usually follow:

1. Install the dependencies if needed

   ```bash
   sudo pacman --sync --refresh --needed base-devel
   ```

2. Clone the AUR repository to be installed. Lets take `google-chrome` for example

   ```bash
   mkdir -p ~/repos/aur.archlinux.org
   cd ~/repos/aur.archlinux.org
   git clone https://aur.archlinux.org/google-chrome.git
   cd yay
   makepkg -si
   yay --sync --refresh --needed google-chrome visual-studio-code-bin zoom
   ```

3. (Optional) Manually verify that the file what you expect them to be

4. Last step is to build and install the package

   ```bash
   makepkg -si
   ```

## Meta

    tags: #linux #arch #bash #cli
