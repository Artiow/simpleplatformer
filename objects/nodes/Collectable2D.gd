class_name Collectable2D
extends Area2D

@export var is_active := true
@export var strategy: CollectableStrategy

var _is_collected := false

signal collected(collector: Collector2D)


func _ready():
	assert(strategy != null, "'strategy' must be assigned in the inspector.")


func try_collect(collector: Collector2D) -> bool:
	if _is_collected or not is_active or not _can_be_collected_by(collector):
		return false
	_collect(collector)
	return true


func _can_be_collected_by(collector: Collector2D) -> bool:
	return strategy._can_apply_to(collector)


func _collect(collector: Collector2D):
	_is_collected = true
	strategy._apply_to(collector)
	collected.emit(collector)
