class_name Level2D
extends Node2D

var _spawn_manager: SpawnManager
var _player_score := 0


func _ready():
	_spawn_manager = SceneUtils.find_singleton_child_in(self, &"SpawnManager") as SpawnManager
	_on_player_score_update()


## Spawns the given [param character] in the level at the spawn point with the specified [param spawn_id].
## Defaults to [code]&"default"[/code] spawn point if none is given.
func spawn_character(character: CharacterBody2D, spawn_id: StringName = &"default"):
	if _spawn_manager:
		_spawn_manager.spawn_character(character, spawn_id)
	else:
		push_error("SpawnManager not initialized in the node tree of %s. Cannot spawn character %s." % [self, character])


func add_player_score(points):
	_player_score += points
	_on_player_score_update()
	print_debug(self, ": points added = %.f, total = %.f" % [points, _player_score])


func _on_player_score_update():
	pass # override to implement custom logic
