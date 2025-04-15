extends Hurtbox2D


func _should_reflect_hit(hitbox: Hitbox2D) -> bool:
	if hitbox.host is EnemySlime:
		return _is_above(get_global_rect(), hitbox.get_global_rect())
	else:
		return false


func _is_above(this: Rect2, other: Rect2) -> bool:
	var intersection := this.intersection(other)
	return intersection.size.x > intersection.size.y and this.get_center().y < other.get_center().y
