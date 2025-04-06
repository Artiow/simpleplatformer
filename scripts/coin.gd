class_name Coin
extends Collectable2D

@onready var _pickup_animation: Callable = $PickupAnimation.play.bind(&"pickup")


func _on_collected(_collector: Collector2D):
	_pickup_animation.call()
