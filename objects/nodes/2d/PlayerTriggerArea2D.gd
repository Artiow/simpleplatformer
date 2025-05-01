class_name PlayerTriggerArea2D
extends Area2D

@export var id: StringName = &"default"
@export var is_active := true

signal triggered(id: StringName, player: Player)


func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D):
	if is_active and body is Player:
		_on_triggered(body as Player)


func _on_triggered(player: Player):
	triggered.emit(id, player)
