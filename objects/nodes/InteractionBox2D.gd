class_name InteractionBox2D
extends Area2D

@export var is_active := true

@export_group("Interaction Host")
## If true, this node ([code]self[/code]) will be used as host,
## unless [member host] is explicitly set.
@export var use_self_as_host := false
## An optional custom host node for this interaction box.
## If set, this overrides both the parent node and [member use_self_as_host].
@export var host: Node2D

var collision_shape: CollisionShape2D
var global_rect: Rect2: get = _get_global_rect


func _ready():
	_init_collision_shape()
	_init_host()


func _init_collision_shape():
	assert(get_child_count() == 1, "%s must have exactly one child node." % self)
	var child := get_child(0)
	assert(child is CollisionShape2D, "the only child of %s must be a CollisionShape2D." % self)
	collision_shape = child


func _init_host():
	if host == null:
		if use_self_as_host:
			host = self
		else:
			var parent := get_parent()
			if parent is Node2D:
				host = parent
			else:
				push_warning("Parent node %s cannot be set as a host node of %s." % [parent, self])


func _get_global_rect() -> Rect2:
	return collision_shape.shape.get_rect() * collision_shape.global_transform
