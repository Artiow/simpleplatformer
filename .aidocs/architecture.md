# architecture

This document outlines the directory layout and how the pieces fit together.
It captures design intent so assistants can understand where new files belong.

## Top-level directories
- **assets/** – static game assets: sprites, sounds, fonts. No scripts live here.
- **scenes/** – reusable scenes and level data. `scenes/core` holds common building blocks while `scenes/levels` contains individual stages.
- **scripts/** – gameplay logic and utilities. `scripts/core` stores foundational nodes and helpers used across the project.
- **resources/** – data assets and script resources referenced via exported properties.
- **editor/** – icons and tools used inside the Godot editor.

`project.godot` defines engine settings and points to the above directories.
Scenes reference scripts under `scripts/`, and scripts rely on resources for
configuration. Keeping these directories separate allows clearer dependencies
and simplifies extending the game.

## Tree

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
