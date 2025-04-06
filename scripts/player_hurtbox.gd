extends Hurtbox2D


func _should_reflect_hit(hitbox: Hitbox2D) -> bool:
	if hitbox.host is EnemySlime:
		var intersection := global_rect.intersection(hitbox.global_rect)
		return intersection.size.x > intersection.size.y
	else:
		return false
