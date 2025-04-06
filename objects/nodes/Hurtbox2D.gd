class_name Hurtbox2D
extends InteractionBox2D

## Emitted when this hurtbox is hit by a valid hitbox.
## Parameter [param attacker] is the node that caused the hit.
signal hit_received(attacker: Node2D)

## Emitted when this hurtbox reflects an incoming hit.
signal hit_reflected()


func _ready():
	super._ready()
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if not is_active or not (area is Hitbox2D):
		return

	var hitbox := area as Hitbox2D
	if not hitbox.is_active:
		return

	if hitbox.reflect_target and _should_reflect_hit(hitbox):
		hitbox.reflect_target._hit_by(host)
		hit_reflected.emit()
	else:
		_hit_by(hitbox.host)


func _hit_by(attacker: Node2D):
	hit_received.emit(attacker)

func _should_reflect_hit(_hitbox: Hitbox2D) -> bool:
	return false # override to implement custom reflect logic
