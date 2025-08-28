class_name LevelRoot
extends Node

@export var player_scene: PackedScene

@onready var camera: Camera2D = $Camera

@onready var restart_timer: Timer = $RestartTimer

var player: Player
var current_level: Level2D

var _current_level_id: int


func _ready():
	SceneUtils.detach_node(camera)
	load_level(0)


func load_level(level_id: int):
	_load_level.call_deferred(level_id)


func _load_level(level_id: int):
	_cleanup()
	_current_level_id = level_id
	_instantiate()
	_construct()
	_on_current_level_enter()


func _cleanup():
	if current_level:
		SceneUtils.free_node(current_level)
	if player:
		SceneUtils.detach_node(camera)
		SceneUtils.free_node(player)


func _instantiate():
	current_level = _instantiate_level(_current_level_id)
	player = _instantiate_player()


func _construct():
	SceneUtils.attach_node_to(player, self)
	SignalUtils.connect_safely(player.death, _on_player_death, CONNECT_ONE_SHOT)
	SceneUtils.attach_node_to(current_level, self)
	SignalUtils.connect_safely(current_level.exit, _on_current_level_exit, CONNECT_ONE_SHOT)


func _on_current_level_enter():
	_spawn_player_on_current_level()


func _spawn_player_on_current_level():
	if current_level.spawn_manager:
		current_level.spawn_manager.spawn_player(player)
		_install_camera_on_current_level()
	else:
		push_error("SpawnManager not initialized in the node tree of current level %s. Cannot spawn player %s." % [current_level.get_path(), player.get_path()])


func _install_camera_on_current_level():
	if not camera.owner:
		current_level.sync_camera_limits(camera)
		Camera2DUtils.attach_camera_to(camera, player)
	else:
		push_error("%s already istalled within the node tree of player %s." % [camera.get_path(), player.get_path()])


func _instantiate_player() -> Player:
	return player_scene.instantiate()


func _instantiate_level(level_id: int) -> Level2D:
	var loading_start := Time.get_unix_time_from_system()
	print_debug("Instantiating level #%d..." % level_id)
	var level := _load_level_scene(level_id).instantiate() as Level2D
	var loading_duration := 1000 * (Time.get_unix_time_from_system() - loading_start)
	print_debug("Level #%d instantiated successfully (%.f ms)" % [level_id, loading_duration])
	return level


func _load_level_scene(level_id: int) -> PackedScene:
	return load("res://scenes/levels/level_%s.tscn" % level_id) as PackedScene


func _on_current_level_exit():
	load_level(_current_level_id + 1)


func _on_player_death():
	_restart()


func _restart():
	Engine.time_scale = 0.5
	restart_timer.start()


func _on_restart_timer_timeout():
	Engine.time_scale = 1
	load_level(_current_level_id)
