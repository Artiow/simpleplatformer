class_name Level2D
extends Node2D

@export_group("Border", "border_")
@export var border_bottom := 10000000
@export var border_left := -10000000
@export var border_right := 10000000
@export var border_top := -10000000

@onready var spawn_manager: SpawnManager = SceneUtils.find_singleton_child_in(self, &"SpawnManager")

## Emitted when the player exits the level.
signal level_exit()


## This method should be connected to the [signal triggered]
## of the [PlayerTriggerArea2D] node responsible for leaving the current level.
func _on_level_exit(id: StringName, player: Player):
	print_debug("%s triggered level %s exit \"%s\"" % [player.get_path(), get_path(), id])
	level_exit.emit()


func sync_camera_limits(camera: Camera2D):
	camera.limit_bottom = border_bottom
	camera.limit_left = border_left
	camera.limit_right = border_right
	camera.limit_top = border_top
