# nodes

Custom node scripts live under `scripts/core/objects/nodes`. They provide reusable behaviors that extend Godot's standard nodes.

## Naming
- Files use `PascalCase` names ending with the node type (e.g. `Hitbox2D.gd`).
- Each script starts with `class_name` so it can be attached in the editor.

## Examples
- `Level2D.gd` manages camera limits and emits signals when the player exits.
- `Hitbox2D.gd` and `Hurtbox2D.gd` implement attack and damage areas.
- `SpawnManager.gd` spawns new instances of scenes at runtime.

## Usage
- Nodes are intended to be instanced in scenes and wired together using signals.
- Properties are exported so level designers can adjust them without editing code.
