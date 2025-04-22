class_name LevelRoot
extends Node

var current_level: Level2D

func _ready():
	current_level = SceneUtils.find_singleton_child_in(self, &"Level2D") as Level2D
