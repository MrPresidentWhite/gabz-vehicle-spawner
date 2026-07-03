# GabZ Vehicle Spawner

A FiveM vehicle spawner for the **GabZ vehicle pack**, featuring a modern NUI menu with categories, search, and multi-language support.

Vehicle data is based on the [GabZ Vehicle Data Repository](https://github.com/JustBlueDolphin/Gabz-Vehicle-Data).

## Features

- **124 GabZ vehicles** across 13 categories
- Modern NUI menu with search (name, brand, spawn code)
- Category filters (Super, Sports, Emergency, etc.)
- Multi-language support (German & English)
- Server-side spawn code validation
- Optional ace permissions for admins
- Automatically deletes the previous spawned vehicle
- Standalone — no external dependencies

## FiveM Server Installation

### Requirements

- A running FiveM server (txAdmin or standalone)
- The **GabZ vehicle pack** installed on the server — this resource only provides the spawner menu, not the vehicle models themselves

### Option A: Download from GitHub (recommended)

1. Download or clone this repository into your server's `resources` folder:

```bash
cd /path/to/your/server/resources
git clone https://github.com/MrPresidentWhite/gabz-vehicle-spawner.git
```

2. The resource folder will be named `gabz-vehicle-spawner`. Make sure it contains `fxmanifest.lua` directly inside.

3. Open your `server.cfg` (or add via txAdmin → Settings → Server Config) and add:

```cfg
ensure gabz-vehicle-spawner
```

4. Restart your server, or run in the server console:

```
refresh
ensure gabz-vehicle-spawner
```

### Option B: Manual install

1. Download the latest release or ZIP from GitHub
2. Extract the folder into your `resources` directory
3. Rename the folder to `gabz-vehicle-spawner` if needed (must match the `ensure` name)
4. Add `ensure gabz-vehicle-spawner` to your `server.cfg`
5. Restart the server

### Folder structure on the server

Your server files should look like this:

```
server/
├── server.cfg
└── resources/
    └── gabz-vehicle-spawner/
        ├── fxmanifest.lua
        ├── config.lua
        ├── client/
        ├── server/
        ├── shared/
        ├── locales/
        └── html/
```

### GabZ vehicle pack

This spawner requires the GabZ vehicles to be installed separately. Make sure:

1. The GabZ vehicle pack resource is installed in `resources/`
2. It is started **before** this spawner in `server.cfg`:

```cfg
ensure gabz-vehicles        # your GabZ pack resource name
ensure gabz-vehicle-spawner
```

3. Vehicle spawn codes in `config.lua` match the models provided by your GabZ pack

### Verify installation

1. Join the server
2. Press `F7` or type `/gabzvehicles` in chat
3. The vehicle menu should open — if models fail to spawn, the GabZ pack is missing or not started

### Updating

```bash
cd /path/to/your/server/resources/gabz-vehicle-spawner
git pull
```

Then restart the resource:

```
restart gabz-vehicle-spawner
```

### Install from GitHub Release (ZIP)

1. Go to [Releases](https://github.com/MrPresidentWhite/gabz-vehicle-spawner/releases)
2. Download `gabz-vehicle-spawner-vX.X.X.zip`
3. Extract into your `resources/` folder — the ZIP already contains the correct `gabz-vehicle-spawner/` folder structure
4. Add `ensure gabz-vehicle-spawner` to your `server.cfg`
5. Restart the server

## Usage

| Action | Control |
|--------|---------|
| Open menu | `F7` or `/gabzvehicles` |
| Spawn vehicle | Click on a vehicle card |
| Close menu | `ESC` |

## Configuration (`config.lua`)

```lua
Config.Locale = 'de'                   -- Language: 'de' or 'en'
Config.OpenKey = 'F7'                  -- Keybind
Config.Command = 'gabzvehicles'        -- Chat command
Config.RequirePermission = false       -- true = permission required
Config.AcePermission = 'gabzvehicles.spawn'
Config.DeletePreviousVehicle = true    -- Delete old vehicle on spawn
Config.WarpIntoVehicle = true          -- Warp player into vehicle
Config.MaxUpgrade = false              -- Apply full upgrades
Config.SpawnDistance = 3.0             -- Spawn distance (meters)
```

### Admin permissions (optional)

In `server.cfg`:

```cfg
add_ace group.admin gabzvehicles.spawn allow
add_principal identifier.license:YOUR_LICENSE group.admin
```

Then in `config.lua`:

```lua
Config.RequirePermission = true
```

## Languages

Set via `Config.Locale` in `config.lua`:

| Value | Language |
|-------|----------|
| `de` | German |
| `en` | English |

To add a new language, create a JSON file in the `locales/` folder (same structure as `de.json` / `en.json`) and register it in `fxmanifest.lua`.

## Categories

| Category | Count |
|----------|-------|
| Super | 9 |
| Sports | 27 |
| Sports Classic | 10 |
| Sedans | 7 |
| Muscle | 6 |
| Compacts | 6 |
| Coupes | 1 |
| SUV | 4 |
| Offroad | 4 |
| Vans | 7 |
| Commercial | 6 |
| Service | 5 |
| Emergency | 32 |

## Releases

Releases are created manually via GitHub Actions.

1. Bump the version in `fxmanifest.lua`
2. Update `CHANGELOG.md` with the new version section
3. Commit and push to `main`
4. Go to **Actions → Release → Run workflow**

The workflow will:

1. Create a **draft** release using the `fxmanifest.lua` version (`v1.0.0`, etc.)
2. Build a `gabz-vehicle-spawner-vX.X.X.zip` asset in standard FiveM format
3. Upload the ZIP to the draft release
4. Validate the draft and **publish** the release

The release description is taken from `CHANGELOG.md`.

## Project structure

```
gabz-vehicle-spawner/
├── .github/workflows/release.yml
├── fxmanifest.lua
├── config.lua
├── CHANGELOG.md
├── scripts/build-release.sh
├── shared/locale.lua
├── locales/
│   ├── de.json
│   └── en.json
├── client/main.lua
├── server/main.lua
└── html/
    ├── index.html
    ├── style.css
    └── script.js
```