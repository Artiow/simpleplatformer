class_name PlayerTrigger
extends Area2D

@export var is_active := true

signal triggered(player: Player)


func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D):
	if is_active and body is Player:
		triggered.emit(body as Player)
