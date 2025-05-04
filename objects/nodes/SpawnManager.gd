class_name SpawnManager
extends Node

@export var default_spawn_id := &"default"

@onready var _spawn_points: Dictionary[StringName, SpawnPoint2D] = _collect_spawn_points()


func _collect_spawn_points() -> Dictionary[StringName, SpawnPoint2D]:
	var spawn_points: Dictionary[StringName, SpawnPoint2D] = {}
	for node in find_children("*", &"SpawnPoint2D"):
		if not node is SpawnPoint2D:
			continue
		var spawn_point := node as SpawnPoint2D
		if spawn_points.has(spawn_point.id):
			push_warning("Duplicate spawn point id: %s" % spawn_point.id)
		spawn_points[spawn_point.id] = spawn_point
	return spawn_points


## Spawns the given [param character] at the spawn point with the specified [param spawn_id].
## Defaults to [member default_spawn_id] spawn point if none is given.
func spawn_character(character: CharacterBody2D, spawn_id: StringName = default_spawn_id):
	var spawn_point = _spawn_points.get(spawn_id)
	if spawn_point is SpawnPoint2D:
		_spawn_character_at(character, spawn_point)
	else:
		push_warning("Spawn point with id '%s' not found." % spawn_id)


func _spawn_character_at(character: CharacterBody2D, spawn_point: SpawnPoint2D):
	character.global_position = spawn_point.global_position
