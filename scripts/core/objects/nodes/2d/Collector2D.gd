@icon("res://editor/icons/arrow-in-box-blue.svg")
class_name Collector2D
extends InteractionBox2D


func _ready():
	super._ready()
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D):
	if is_active and area is Collectable2D:
		area.try_collect(self)
