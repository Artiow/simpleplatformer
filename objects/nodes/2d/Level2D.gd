class_name Level2D
extends Node2D

var _spawn_manager: SpawnManager
var _player_session: PlayerLevelSession


func _ready():
	_spawn_manager = SceneUtils.find_singleton_child_in(self, &"SpawnManager") as SpawnManager
	_player_session = SceneUtils.find_singleton_child_in(self, &"PlayerLevelSession") as PlayerLevelSession


## Spawns the given [param character] in the level at the spawn point with the specified [param spawn_id].
## Defaults to [code]&"default"[/code] spawn point if none is given.
func spawn_character(character: CharacterBody2D, spawn_id: StringName = &"default"):
	if _spawn_manager:
		_spawn_manager.spawn_character(character, spawn_id)
	else:
		push_error("SpawnManager not initialized in the node tree of %s. Cannot spawn character %s." % [get_path(), character.get_path()])
