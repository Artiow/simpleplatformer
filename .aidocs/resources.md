# resources

Resource scripts and data files provide tunable gameplay parameters. They are stored under `scripts/core/objects/resources` and `resources/`.

## Script resources
- Strategy scripts such as `CollectableStrategy.gd` and `ScoreStrategy.gd` define behaviors that can be swapped in the editor.
- They use `class_name` so they show up in the resource picker.

## Data resources
- `.tres` files in `resources/` hold shapes, sprite frames and other configuration data.
- These files are referenced by scenes and scripts via exported properties.

## Purpose
- Separating data from code lets designers adjust gameplay without changing scripts.
- Scriptable strategies encourage clean extension of features like scoring or item collection.
