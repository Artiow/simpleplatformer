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

var _rect: Rect2


func _ready():
	_init_rect()
	_init_host()


func _init_rect() -> void:
	# shapes actually is Array[CollisionShape2D]
	var shapes := _find_child_collision_shapes()

	if shapes.is_empty():
		push_warning("%s has no CollisionShape2D children with provided shape." % self)

	else:
		var first_shape := shapes[0] as CollisionShape2D
		_rect = first_shape.transform * first_shape.shape.get_rect()
		for i in range(1, shapes.size()):
			var shape := shapes[i] as CollisionShape2D
			_rect = _rect.merge(shape.transform * shape.shape.get_rect())


func _find_child_collision_shapes() -> Array:
	return find_children("*", &"CollisionShape2D", false).filter(func(e): return e is CollisionShape2D and e.shape != null)


func _init_host():
	if host == null:
		if use_self_as_host:
			host = self
		else:
			var parent := get_parent()
			if parent is Node2D:
				host = parent
			else:
				push_warning("Parent node %s cannot be set as an interaction host node of %s." % [parent, self])


func get_global_rect() -> Rect2:
	return global_transform * _rect
