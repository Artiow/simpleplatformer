class_name PlatformBig
extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite
@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var monitoring_area: Area2D = $MonitoringArea

@export var sprite_texture: Texture2D:
	set(value):
		sprite_texture = value
		_apply_sprite_texture()


func _ready():
	_apply_sprite_texture()


func _apply_sprite_texture():
	if is_node_ready() and sprite_texture:
		sprite.texture = sprite_texture


func drop_through():
	_enable_monitoring.call_deferred()


func _on_monitoring_area_body_entered(_body: Node2D):
	_disable_collision.call_deferred()


func _on_monitoring_area_body_exited(_body: Node2D):
	_enable_collision.call_deferred()


func _enable_monitoring():
	monitoring_area.monitoring = true


func _disable_collision():
	collision_shape.disabled = true


func _enable_collision():
	collision_shape.disabled = false
	monitoring_area.monitoring = false
