# GlupShell: Hyprland + QuickShell Dotfiles Plan

_You're building a polished, dark, frosted, AMOLED-style desktop layer — call it GlupShell. This repo bundles Hyprland tweaks, QuickShell/QML panels (left dock with Omarchy menu), helper scripts, theme tokens, and install instructions. It will be production-ready for a dotfiles repo: documented, modular, and easy to fork._

---

## Repository Overview (what this repo will contain)

```
glups-hypr-quickshell/            # repo root
├── README.md                     # repo landing doc (install + quick start)
├── LICENSE                       # MIT or your choice
├── hyprland/                     # hyprland configuration snippets
│   ├── hyprland.conf             # recommended additions & keybinds
│   └── windowrules.conf          # animations + rules
├── quickshell/                   # QuickShell config + QML panels
│   ├── config.yml
│   ├── colors.qml
│   ├── components/
│   │   ├── GlassCard.qml
│   │   └── MenuItem.qml
│   └── panels/
│       ├── leftdock.qml
│       ├── topbar.qml
│       └── bottomdock.qml (optional)
├── scripts/                      # small helpers and wrappers
│   ├── omarchy-menu              # original Omarchy script (or a wrapper)
│   ├── omarchy-json.sh           # optional JSON-mode wrapper
│   ├── open-settings.sh
│   └── toggle-nightlight.sh
├── theme/                        # theme tokens & CSS for wofi/rofi if used
│   ├── style.css
│   └── wofi.css
├── fonts/                        # font install hints (not included binary)
│   └── README-fonts.md
├── systemd/                      # user units (optional)
│   └── quickshell.service
├── docs/                         # guides: customizing, contributing, design notes
│   ├── DESIGN.md
│   └── CONTRIBUTING.md
└── example/                      # example dotfiles install scripts / safe defaults
    └── install.sh
```

---

## Goals (from highest to lowest priority)
1. Ship a **left hover dock** with Omarchy menu integration (click runs existing script or in-QML menu via JSON).  
2. Provide **glassmorphism** theme tokens and QML components (GlassCard) so all panels look consistent.  
3. Keep **Bash/Omarchy logic** intact — call it from QML via `Process {}` or wrapper script.  
4. Offer **Hyprland rules** to ensure panels animate cleanly and avoid compositing issues.  
5. Document installation, bind the dock to the left-edge hover, provide optional keybinds.  
6. Provide a small, opinionated color scheme (AMOLED dark + accent) and Nerd Font guidance.

---

## Design & Visual Language
- **Primary**: #{0b0d10} deep almost-black background.  
- **Panel**: translucent dark (`#0f1417cc`) with soft border and subtle accent (`#3b83b8`).  
- **Typography**: JetBrainsMono Nerd Font (icons via glyphs).  
- **Corner radius**: 12–16px.  
- **Animations**: `NumberAnimation` for position/opacity and `SpringAnimation` for scale on hover.  
- **Cards**: glassy cards using semi-transparent fill + light border + backdrop blur where supported.

---

## Files: purpose and sample content

### `hyprland/hyprland.conf` (snippets)
- Add autostart for QuickShell: `exec-once = quickshell --config ~/.config/quickshell/config.yml`
- Keybind to toggle dock (optional): `bind = SUPER, SPACE, exec, quickshellctl toggle panels/leftdock.qml`
- Ensure compositor animations are enabled for extra polish (optional):
```ini
animations {
    enabled = yes
}
# windowrule examples
windowrulev2 = animation slide, class:^(wofi|rofi)$
```

### `quickshell/config.yml`
- Declares which panels to load:
```yaml
panels:
  - path: panels/topbar.qml
  - path: panels/leftdock.qml
```

### `quickshell/colors.qml`
- Theme tokens; imported by components.

### `quickshell/components/GlassCard.qml`
- Reusable frosted card with `Behavior` animations on `opacity` and `scale`.

### `quickshell/panels/leftdock.qml`
- Hover hotspot at extreme left; slides open with `x` animation; contains a `ListModel` of menu items.  
- Items call `Process { command: [...] }` to run `omarchy-menu` or shell commands.

### `scripts/omarchy-menu`
- Keep your existing script. Add a small `--list-mode` or `--json` flag that outputs JSON if you want embedded menus inside QML. (Optional.)

### `scripts/omarchy-json.sh`
- Example wrapper that prints JSON for the requested submenu. QML can load that file or call it and parse JSON to populate `ListModel`.

### `theme/style.css` and `wofi.css`
- Provide basic CSS for Wofi/Rofi so any child popup matches the same look.

---

## Installation steps (what we will put in `example/install.sh`)
1. Clone repo into `~/.config/glups-hypr-quickshell` or `~/Dotfiles/glups-hypr-quickshell`.  
2. Install prerequisites: `quickshell`, `hyprland`, `grio/slurp` (screenshot tools), `ttf-jetbrains-mono-nerd`.  
3. Copy or symlink `~/.config/quickshell/*` and `~/.config/hypr/*` snippets into place (or provide `stow` script).  
4. Make `scripts/*.sh` executable.  
5. Add `exec-once = quickshell --config ~/.config/quickshell/config.yml` to `hyprland.conf` or enable systemd user unit.  
6. Restart Hyprland or session.

Notes: Always back up existing configs. The installer will not overwrite without confirmation.

---

## Development & Contribution guide
- Keep QML components small and reusable.  
- Avoid large monolithic QML files — split into `components/` and `panels/`.  
- For dynamic menus, prefer JSON output from scripts and load with `Qt.labs.folderlistmodel` or a simple tiny file read into `ListModel`.

`CONTRIBUTING.md` should include linting (QML lint? optional), code format, and a checklist to add a new panel.

---

## README.md (outline)
- Project purpose + screenshots.  
- Quick start: install prerequisites, clone repo, run install script.  
- How to customize colors (edit `colors.qml`).  
- How to add a new menu item (edit `leftdock.qml`'s `ListModel` or update `omarchy-json.sh`).  
- Troubleshooting: fonts missing, Process not available, QML debug tips.

---

## Example developer workflow (how you iterate)
1. Edit `components/GlassCard.qml` to tweak radius, blur, or animation timing.  
2. Run `quickshell --config ~/.config/quickshell/config.yml` for live-reload testing.  
3. Change `leftdock.qml` model to call the new script.  
4. When stable, commit and push. Use PRs for bigger changes.

---

## Packaging for dotfiles repository
- Use `stow` or symlink convention in `example/install.sh`.  
- Keep `scripts/` executable and small.  
- Add a `meta.json` describing project version, required packages, and compat notes.  
- Add a `LICENSE` (MIT recommended) and `CODE_OF_CONDUCT.md`.

---

## TODO (initial)
- [ ] Add full `hyprland.conf` recommended snippets.  
- [ ] Finalize `GlassCard.qml` with `QtGraphicalEffects` blur fallback detection.  
- [ ] Add `omarchy-json.sh` integration and a QML example of populating `ListModel` from a JSON file.  
- [ ] Add topbar dropdown card with animated chart placeholder.  
- [ ] Add fallback path if `Process {}` not found (tiny socket/DBus helper).

---

## Suggested commit structure
1. `init: repo skeleton and README`  
2. `feat: leftdock.qml + GlassCard component`  
3. `feat: topbar.qml + basic dropdown`  
4. `chore: install script + hyprland snippets`  
5. `docs: CONTRIBUTING + DESIGN`  

---

## Example README excerpt (for the repo top)
```
# GlupShell
Polished Hyprland + QuickShell dotfiles: left-hover Omarchy dock, frosted glass UI, and animated panels.

Quick start:

    git clone https://github.com/youruser/glups-hypr-quickshell.git
    cd glups-hypr-quickshell/example
    ./install.sh

Customize colors by editing `quickshell/colors.qml`.
```

---

## Final notes (why this is the right approach)
- QuickShell/QML handles visuals and animations with minimal work.  
- Bash/Omarchy remains your brain — you won't rewrite menus.  
- The dotfiles repo becomes a clean, modular, and forkable project.

---

If you want, I can now:  
- generate all the files in the repo (full, pasteable contents for each file), or  
- create a ready-to-copy `install.sh` and `README.md` for the repo root.

Which one do you want me to produce right now?

