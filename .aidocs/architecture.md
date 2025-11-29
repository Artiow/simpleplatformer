# architecture.md

This document outlines the directory layout and how the pieces fit together.
It captures design intent so assistants can understand where new files belong.

## Top-level directories

- **assets/** – static game assets: sprites, sounds, fonts. No scripts live here.
- **editor/** – icons and tools used inside the Godot editor.
- **resources/** – data assets and script resources referenced via exported properties.
- **scenes/** – reusable scenes and level data. `scenes/core` holds common building blocks while `scenes/levels` contains individual stages.
- **scripts/** – gameplay logic and utilities. `scripts/core` stores foundational nodes and helpers used across the project.

`project.godot` defines engine settings and points to the above directories.
Scenes reference scripts under `scripts/`, and scripts rely on resources for
configuration. Keeping these directories separate allows clearer dependencies
and simplifies extending the game.

## Directory tree

```
.
├── assets
│   ├── fonts
│   ├── music
│   ├── sounds
│   └── sprites
├── editor
│   └── icons
├── resources
│   └── core
├── scenes
│   ├── core
│   └── levels
└── scripts
    └── core
        └── objects
            ├── nodes
            │   ├── 2d
            │   └── tools
            └── resources
```

## Directory descriptions

### `assets/`
Artwork and audio used by the game, subdivided into fonts, background music, sound effects, and sprite images.

- **`fonts/`** – Pixel-style typefaces for UI and in-game text
- **`music/`** – Background soundtrack files (e.g., `time_for_adventure.mp3`)
- **`sounds/`** – Sound effects such as coin collection and jumping
- **`sprites/`** – PNG images for characters, platforms, and other visual elements

---

### `editor/`
Assets supporting custom editor tooling; currently only icon graphics.

- **`icons/`** – SVG icons displayed in the Godot editor for specialized tools

---

### `resources/`
Reusable Godot resource files (textures, shapes, strategy resources) shared across scenes.

- **`core/`** – Foundational resources like collision shapes and boundary definitions

---

### `scenes/`
Godot `.tscn` scenes defining gameplay objects and levels.

- **`core/`** – Core scene templates for triggers, level entry/exit, abyss boundaries, etc.
- **`levels/`** – Complete playable level scenes (e.g., `level_0.tscn`, `level_1.tscn`)

---

### `scripts/`
GDScript source code powering gameplay and utilities.

- **`core/`** – Central gameplay logic and framework components
    - **`objects/`** – Reusable object implementations split into nodes and resource classes
        - **`nodes/`** – Scripted nodes for gameplay entities and systems
            - **`2d/`** – 2D-specific nodes like `Collectable2D`, `Hitbox2D`, and spawn points
            - **`tools/`** – Node-based editor tools for level design and debugging
        - **`resources/`** – Resource classes such as scoring or collectable strategies  
