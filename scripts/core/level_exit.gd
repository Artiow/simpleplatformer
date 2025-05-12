class_name LevelExit
extends Node2D

enum Direction {LEFT, RIGHT}

@export var direction := Direction.RIGHT:
	set(value):
		direction = value
		LevelExit._sync_scale(self)

@onready var enter_trigger: PlayerTrigger = $EnterTrigger
@onready var exit_trigger: PlayerTrigger = $ExitTrigger

signal entered(player: Player)
signal reached(player: Player)


func _ready():
	LevelExit._sync_scale(self)


func _on_enter_trigger_triggered(player: Player):
	player.control_locked = true
	player.moving_direction = scale.x
	enter_trigger.is_active = false
	exit_trigger.is_active = true
	entered.emit(player)


func _on_exit_trigger_triggered(player: Player):
	player.moving_direction = 0.0
	player.control_locked = false
	exit_trigger.is_active = false
	enter_trigger.is_active = true
	reached.emit(player)


static func _sync_scale(this: LevelExit):
	this.scale.x = 1.0 if this.direction else -1.0
	this.scale.y = 1.0
