# Repository Guidelines

## Project Structure & Module Organization
Scenes live in `scenes/` (levels under `scenes/levels/`, reusable prefabs in `scenes/core/`), while gameplay logic sits in `scripts/` and its nested `core/objects/` helpers. Visual and audio assets are grouped by type in `assets/` (sprites, fonts, music, editor icons), and re-usable `*.tres` resources stay under `resources/`. Consult `project.godot` for autoloads and global settings; custom editor tools are in `scripts/core/objects/nodes/tools/`.

## Build, Test, and Development Commands
Use the Godot 4 binary installed on your system:
- `godot --editor project.godot` opens the project for scene authoring and script editing.
- `godot --path . --run main` launches the game starting from `scenes/main.tscn` for manual playtesting.
- `godot --headless --path . --run main` is useful for smoke tests in CI where a GUI is unavailable.
Keep `godot` on PATH (or replace with the exact executable name on your machine).

## Coding Style & Naming Conventions
Stick to Godot 4 / GDScript defaults: indent with four spaces, keep lines under ~100 chars, and favor explicit types for exported properties. Scene files should use PascalCase node names (`PlayerLevelSession`), while script filenames stay snake_case (`scripts/player_hurtbox.gd`). Prefix tool scripts with `@tool` when they run in the editor and keep utility classes inside `scripts/core/objects/` to avoid circular dependencies.

## Testing Guidelines
Automated tests are not yet configured; rely on manual playthroughs. Before opening a PR, run `godot --path . --run main`, verify that level transitions, double-jump, enemy AI, and collectables behave correctly, and watch the Godot output panel for warnings. If you add regression tests (e.g., with the GUT addon under `addons/`), place them in a `tests/` directory and name them after the feature (`test_player_jump.gd`).

## Commit & Pull Request Guidelines
Commits follow short, imperative summaries (`icons moved to assets`) with optional issue references like `(#9)`. Keep related changes squashed, include brief rationale lines when touching gameplay balance, and avoid WIP commits. PRs should describe gameplay changes, include reproduction or verification steps, mention impacted scenes/scripts, and add screenshots or GIFs for visual tweaks.

## Asset & Scene Tips
Reuse textures from `resources/` via drag-and-drop to keep draw calls low, and prefer instancing existing scenes (`scenes/enemy_slime.tscn`) instead of duplicating nodes. Store new sound effects beneath `assets/sounds/` and commit the source files to simplify re-exporting.
