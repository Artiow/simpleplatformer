@icon("res://editor/icons/SpawnManager.svg")
class_name SpawnManager
extends Node

@export var default_spawn_id := &"default"

@onready var _spawn_points: Dictionary[StringName, Spawn2D] = _find_spawns_in([owner, self])


## Spawns the given [param player] at the spawn with the specified [param spawn_id].
## Defaults to [member default_spawn_id] spawn if none is given.
func spawn_player(player: Player, spawn_id: StringName = default_spawn_id):
	var spawn = _spawn_points.get(spawn_id)
	if spawn is Spawn2D:
		_spawn_player_at(player, spawn as Spawn2D)
	else:
		push_warning("Spawn point with id '%s' not found." % spawn_id)


func _spawn_player_at(player: Player, spawn: Spawn2D):
	spawn.place(player)


static func _find_spawns_in(nodes: Array[Node]) -> Dictionary[StringName, Spawn2D]:
	var spawn_points: Dictionary[StringName, Spawn2D] = {}
	for node in nodes:
		for child in SceneUtils.find_children_in(node, &"Spawn2D"):
			if child is not Spawn2D:
				continue
			var spawn_point := child as Spawn2D
			if spawn_points.has(spawn_point.id):
				push_warning("Duplicate spawn point id: %s" % spawn_point.id)
			spawn_points[spawn_point.id] = spawn_point
	return spawn_points
