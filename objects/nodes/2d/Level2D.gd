class_name Level2D
extends Node2D

@export var player_score_label: FormatLabel

var _player_spawn_point: SpawnPoint2D
var _player_score := 0


func _ready():
	_init_player_spawn_point()
	_update_player_score_label()


func _init_player_spawn_point():
	var spawn_array := find_children("*", &"SpawnPoint2D")
	assert(not spawn_array.is_empty(), "no SpawnPoint2D found in level.")
	_player_spawn_point = spawn_array[0]
	if spawn_array.size() > 1:
		push_warning("Multiple SpawnPoint2D nodes found. Using the first one.")


func _update_player_score_label():
	if player_score_label:
		player_score_label.format([_player_score])


func spawn_player(player: Player):
	player.global_position = _player_spawn_point.global_position


func add_player_score(points):
	_player_score += points
	_update_player_score_label()
	print_debug(self, ": points added = %.f, total = %.f" % [points, _player_score])
