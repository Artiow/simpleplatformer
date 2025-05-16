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
	var offset_x := floori(camera.offset.x)
	var offset_y := floori(camera.offset.y)
	camera.limit_bottom = border_bottom - offset_y
	camera.limit_left = border_left - offset_x
	camera.limit_right = border_right - offset_x
	camera.limit_top = border_top - offset_y
