@icon("res://assets/editor/icons/collectable-blue.svg")
class_name Collectable2D
extends Area2D

@export var is_active := true
@export var strategy: CollectableStrategy

var _is_collected := false

## Emitted when this collectable is successfully by [param collector].
signal collected(collector: Collector2D)


func _ready():
	if not strategy:
		push_warning("%s has no provided CollectableStrategy. Collectable will be inert." % self)


func try_collect(collector: Collector2D):
	if not strategy:
		push_warning("Cannot collect %s without a provided CollectableStrategy." % self)
	elif _can_be_collected_by(collector):
		_collect_by(collector)


func _can_be_collected_by(collector: Collector2D) -> bool:
	return is_active and not _is_collected and strategy._can_apply_to(collector)


func _collect_by(collector: Collector2D):
	_is_collected = true
	strategy._apply_to(collector)
	collected.emit(collector)
