class_name ScoreStrategy
extends CollectableStrategy

@export var value: int = 1


func _can_apply_to(collector: Collector2D) -> bool:
	return collector.host is Player


func _apply_to(collector: Collector2D):
	(collector.host as Player).add_score(value)
