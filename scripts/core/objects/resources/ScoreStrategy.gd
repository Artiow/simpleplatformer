class_name ScoreStrategy
extends CollectableStrategy

@export var value: int = 1

signal score_awarded(value: int)


func _can_apply_to(collector: Collector2D) -> bool:
	return collector.host is Player


func _apply_to(_collector: Collector2D):
	score_awarded.emit(value)
