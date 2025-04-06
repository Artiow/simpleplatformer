class_name Hurtbox2D
extends InteractionBox2D

## Emitted when this hurtbox is hit by a valid hitbox.
## Parameter [param source] is the node that caused the hit.
signal hit_received(source: Node2D)


func _ready():
	super._ready()
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if not is_active or not (area is Hitbox2D):
		return

	var hitbox := area as Hitbox2D
	if not hitbox.is_active:
		return

	hit_received.emit(hitbox.host)
