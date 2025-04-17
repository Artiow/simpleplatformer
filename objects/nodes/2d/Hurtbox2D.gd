class_name Hurtbox2D
extends InteractionBox2D

## Emitted when this hurtbox is hit by a valid hitbox or another hurtbox.
## Parameter [param hit_source] is the node that caused the hit.
signal hit_received(hit_source: InteractionBox2D)

## Emitted when this hurtbox reflects an incoming hit.
## Parameter [param hit_source] is the hitbox that caused the incoming hit.
signal hit_reflected(hit_source: Hitbox2D)


func _ready():
	super._ready()
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D):
	if is_active and area is Hitbox2D and area.is_active:
		_on_hit(area as Hitbox2D)


func _on_hit(hitbox: Hitbox2D):
	if hitbox.reflect_target and hitbox.reflect_target.is_active and _should_reflect_hit(hitbox):
		hitbox.reflect_target.hit_received.emit(self)
		hit_reflected.emit(hitbox)
	else:
		hit_received.emit(hitbox)


func _should_reflect_hit(_hitbox: Hitbox2D) -> bool:
	return false # override to implement custom reflect logic
