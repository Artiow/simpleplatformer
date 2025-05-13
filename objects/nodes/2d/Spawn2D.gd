class_name Spawn2D
extends Marker2D

@export var id: StringName = &"default"


func place(player: Player):
	player.global_position = global_position
