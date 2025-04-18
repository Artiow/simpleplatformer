class_name ScoreStrategy
extends CollectableStrategy

@export var value: int = 1


func _can_apply_to(collector: Collector2D) -> bool:
	return collector.actor is Player


func _apply_to(collector: Collector2D):
	(collector.actor as Player).current_level.add_player_score(value)
