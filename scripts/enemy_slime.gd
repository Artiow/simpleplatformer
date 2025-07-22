class_name EnemySlime
extends CharacterBody2D

enum MaxDistanceType {RELATIVE, GLOBAL}

@onready var sprite: AnimatedSprite2D = $AnimatedSprite
@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var hitbox: Hitbox2D = $Hitbox
@onready var hurtbox: Hurtbox2D = $Hurtbox
@onready var wall_raycast: RayCast2D = $WallRayCast

@onready var kill_timer: Timer = $KillTimer
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

var _sprite_frames: SpriteFrames
@export var sprite_frames: SpriteFrames:
       set(value):
               _sprite_frames = value
               _apply_sprite_frames()
       get:
               return _sprite_frames

@export var max_distance_type := MaxDistanceType.RELATIVE
@export var max_distance := 1000.0
@export var speed := 50.0
@export var death_jump_velocity := -100.0

var _position_supplier: Callable
var _start_position: Vector2
var _direction := 1
var _is_dead := false


func _ready():
	if max_distance_type:
		_position_supplier = get_global_position
	else:
		_position_supplier = get_position

	_start_position = _position_supplier.call()
	velocity.x = _direction * speed
	_apply_sprite_frames()


func _apply_sprite_frames():
	if is_node_ready() and sprite_frames:
		sprite.sprite_frames = sprite_frames
		sprite.play()


func _physics_process(delta: float):
	if _can_move():
		velocity.x = _direction * speed
	else:
		if velocity.x:
			# if can't move and has horizontal velocity
			velocity.x = move_toward(velocity.x, 0, speed * delta)
		if not is_on_floor():
			# if can't move and not is on floor 
			velocity.y += get_gravity().y * delta

	move_and_slide()

	if _can_move() and _should_turn_back():
		flip()


func _can_move() -> bool:
	return is_on_floor() and not _is_dead


func _should_turn_back() -> bool:
	return wall_raycast.is_colliding() or is_far_from_start()


func is_far_from_start() -> bool:
	return abs(_position_supplier.call().x - _start_position.x) > max_distance


func flip():
	_direction *= -1
	wall_raycast.target_position.x *= -1
	sprite.flip_h = not sprite.flip_h


func _on_hurtbox_hit_received(hit_source: InteractionBox2D):
	_kill(hit_source.host)


func _kill(killer: Node2D):
	if not _is_dead:
		_is_dead = true
		_handle_death()
		kill_timer.start()
		print_debug(self, " is killed by ", killer)


func _handle_death():
	velocity.y = death_jump_velocity
	collision_shape.queue_free()
	hitbox.queue_free()
	hurtbox.queue_free()
	_play_death_animation()


func _play_death_animation():
	sprite.play(&"death")
	death_sound.play()


func _on_kill_timer_timeout():
	queue_free()
