class_name SpawnManager
extends Node

var _spawn_points: Dictionary[StringName, SpawnPoint2D] = {}


func _ready():
	_init_spawn_points()


func _init_spawn_points():
	for node in find_children("*", &"SpawnPoint2D"):
		var spawn_point := node as SpawnPoint2D
		if _spawn_points.has(spawn_point.id):
			push_warning("Duplicate spawn point id: %s" % spawn_point.id)
		_spawn_points[spawn_point.id] = spawn_point


## Spawns the given [param character] at the spawn point with the specified [param spawn_id].
## Defaults to [code]&"default"[/code] spawn point if none is given.
func spawn_character(character: CharacterBody2D, spawn_id: StringName = &"default"):
	var spawn_point = _spawn_points.get(spawn_id)
	if spawn_point is SpawnPoint2D:
		_spawn_character_at(character, spawn_point)
	else:
		push_warning("Spawn point with id '%s' not found." % spawn_id)


func _spawn_character_at(character: CharacterBody2D, spawn_point: SpawnPoint2D):
	character.global_position = spawn_point.global_position
