## 🌀 My Hyprland Setup

A personal Hyprland configuration built from scratch — tuned for performance, aesthetics, and full reusability.
This repository serves as my **portable Linux environment**, allowing me to reinstall and sync my Hyprland setup anywhere, anytime.

---

### 🌱 About

This project is my rolling Hyprland configuration. Every tweak, package, and script I use is version-controlled here, building toward a full system that I can restore instantly after a clean Arch install. So do with it as you will.

Think of it as my own reproducible Linux environment: same look, same workflow, zero setup hassle.

---

### 🧩 Features

#### ⚙️ Core Environment

* **Hyprland** – dynamic tiling Wayland compositor
* **Hypridle / Hyprlock / Hyprpaper / Hyprpicker / Hyprshot** – complete Hyprland ecosystem
* **Waybar** – custom top bar with modules, scripts, and blur effects
* **Wofi / Rofi** – beautiful app launchers with frosted glass theming
* **Mate-polkit / polkit-gnome** – authentication dialogs for root actions
* **xdg-desktop-portal-hyprland** – desktop integration layer for Hyprland

#### 🖥️ Desktop & UI

* **Plasma Meta / Workspace / System Monitor** – integrated KDE utilities
* **Kvantum + Qt5ct** – unified Qt theming
* **KDEConnect** – mobile-to-PC integration
* **Ark / Dolphin / Gwenview / Okular / KCalc** – KDE essentials

#### 🔊 Audio & Media

* **Pipewire + Wireplumber** – modern audio stack
* **Pavucontrol** – volume mixer
* **EasyEffects** – audio filters and EQ
* **Pamixer** – terminal audio control

#### 🧠 Utilities

* **CopyQ** – advanced clipboard manager
* **Grim + Slurp + Swappy** – region screenshots & editing
* **Wlogout** – logout/power menu
* **Deskflow / Localsend** – local file transfer
* **Smartmontools** – disk health tools
* **Reflector / Pacman-Contrib / Rsync** – system maintenance

#### 🧰 Developer Tools

* **Git / Neovim / Vim / Rust / Python-pip / CMake / Base-devel** – build-ready toolchain
* **Code (VSCode)** – main IDE
* **Zed** – modern lightweight code editor
* **JQ / Expac / Tree** – data inspection tools

#### 🌐 Network & Web

* **NetworkManager / iwd / wpa_supplicant / nm-applet** – wireless control
* **Firefox / Google Chrome / Telegram Desktop / OnionShare** – browsers and messaging

#### 🎨 Aesthetics & Fonts

* **ttf-jetbrains-mono-nerd** – clean developer font
* **Hyprland Borders++ Plugin** – custom border animations
* **Kwin-Effects-Forceblur** – global blur effects for windows
* **Hyprpaper Randomizer Script** – wallpaper cycling setup

#### 🧹 System Management

* **Monit** – lightweight process monitoring
* **Zram-Generator** – compressed RAM swap
* **HTOP / Neofetch / Inxi** – system overview utilities

#### 📦 Package Management

* **Pacman + Yay** – core and AUR package management
* **Flatpak** – sandboxed applications

#### 🖼️ Multimedia

* **Handbrake / FFmpeg / Upscayl-AppImage** – video & image processing

#### 💾 Virtualization & Boot

* **VirtualBox + Host Modules** – VMs
* **GRUB + EFIBootMgr + Os-Prober** – bootloader management

#### 🔋 GPU / Drivers

* **Vulkan-Radeon / XF86-Video-AMD / AMD-UCODE** – AMD graphics stack

---

### 🧠 Philosophy

> "Build your system like you build software — version it, test it, break it, fix it, commit it."

This setup is about **control** and **reproducibility** — I can reinstall Arch, pull this repo, and get my environment back within minutes.

---

### 🧩 Folder Structure

```bash
.
├── hypr/                # Hyprland configs (main + keybinds)
│   ├── hyprland.conf
│   ├── keybinds.conf
│   └── scripts/
│       ├── screenshot.sh
│       └── wall-random.sh
├── waybar/              # Waybar configs + themes
├── rofi/                # Rofi configs + frosted glass theme
├── wallpapers/          # Local wallpapers
└── README.md
```

---

### ⚙️ Installation

```bash
# Clone this repo
 git clone https://github.com/<yourusername>/hyprland-setup.git ~/.config

# Install base dependencies
 sudo pacman -S hyprland waybar rofi hyprpaper grim slurp swappy copyq pamixer brightnessctl

# Start Hyprland
 Hyprland
```

*(Future plan: add an install script for full auto setup.)*

---

### 🛠️ Future Goals

* [ ] Automated installer script (link configs + install packages)
* [ ] Unified theming between Waybar, Rofi, and Wallpaper
* [ ] Blur + transparency consistency for all UI layers
* [ ] Add backup & restore system
* [ ] Create an ISO or bootstrap script for full system restoration

---

### 🩷 Credits / Inspiration

* [ML4W Dotfiles](https://github.com/mylinuxforwork/dotfiles)
* [Hyprdots](https://github.com/prasanthrangan/hyprdots)
* [End-4 Hyprland Dots](https://github.com/end-4/dots-hyprland)
* Community setups from r/unixporn & Hyprland Discord

---

### 🪶 License

MIT License – free to use, modify, and learn from.
