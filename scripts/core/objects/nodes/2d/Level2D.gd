@icon("res://editor/icons/tile-landmark-blue.svg")
class_name Level2D
extends Node2D

@export_group("Border", "border_")
@export var border_bottom := 10000000
@export var border_left := -10000000
@export var border_right := 10000000
@export var border_top := -10000000

@onready var spawn_manager: SpawnManager = SceneUtils.find_singleton_child_in(self, &"SpawnManager")

## Emitted when the player exits the level.
signal exit()


## This method should be connected to the [signal reached]
## of the [LevelExit] node responsible for leaving the current level.
func _on_level_exit_reached(player: Player):
	print_debug("%s reached the level %s exit" % [player.get_path(), get_path()])
	exit.emit()


func sync_camera_limits(camera: Camera2D):
	camera.limit_bottom = border_bottom
	camera.limit_left = border_left
	camera.limit_right = border_right
	camera.limit_top = border_top
