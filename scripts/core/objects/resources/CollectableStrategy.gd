class_name CollectableStrategy
extends Resource


func _can_apply_to(_collector: Collector2D) -> bool:
	return true # override to implement custom logic


func _apply_to(_collector: Collector2D):
	pass # override to implement custom logic
