class_name LevelEnter
extends Spawn2D

enum Direction {LEFT, RIGHT}

@export var direction := Direction.RIGHT:
	set(value):
		direction = value
		LevelEnter._sync_scale(self)

@onready var enter_trigger: PlayerTrigger = $EnterTrigger

signal reached(player: Player)


func _ready():
	LevelEnter._sync_scale(self)


func place(player: Player):
	super.place(player)
	_on_place(player)


func _on_place(player: Player):
	player.lock_movement(scale.x)
	PhysicsFrameScheduler.start_one_shot(self, _enable_enter_trigger)


func _enable_enter_trigger():
	enter_trigger.is_active = true


func _on_enter_trigger_triggered(player: Player):
	player.unlock_movement()
	enter_trigger.is_active = false
	reached.emit(player)


static func _sync_scale(this: LevelEnter):
	this.scale.x = 1.0 if this.direction else -1.0
	this.scale.y = 1.0
