class_name Level2D
extends Node2D

@onready var spawn_manager: SpawnManager = SceneUtils.find_singleton_child_in(self, &"SpawnManager")

## Emitted when the player exits the level.
signal level_exit()


## This method should be connected to the [signal triggered]
## of the [PlayerTriggerArea2D] node responsible for leaving the current level.
func _on_level_exit(id: StringName, player: Player):
	print_debug("%s triggered level %s exit \"%s\"" % [player.get_path(), get_path(), id])
	level_exit.emit()
