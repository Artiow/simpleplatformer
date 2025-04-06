class_name Collector2D
extends Area2D

@export var is_active := true

@export_group("Collection Actor")
## If enabled, this node (i.e. [code]self[/code]) will be used
## as the actor performing the collection, unless [member actor] is explicitly set.
@export var use_self_as_actor := false
## An optional custom actor node for this collector.
## If set, this overrides both the parent node and [member use_self_as_actor].
@export var actor: Node2D


func _ready():
	_init_actor()
	area_entered.connect(_on_area_entered)


func _init_actor():
	if actor == null:
		if use_self_as_actor:
			actor = self
		else:
			var parent := get_parent()
			if parent is Node2D:
				actor = parent
			else:
				push_warning("Parent node ", parent, " cannot be set as actor node.")


func _on_area_entered(area: Area2D):
	if is_active and area is Collectable2D:
		area.try_collect(self)
