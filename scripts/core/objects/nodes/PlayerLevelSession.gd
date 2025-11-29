@icon("res://assets/editor/icons/knight-white.svg")
class_name PlayerLevelSession
extends Node

@export_group("Player Score Processing")
@export var score_strategy: ScoreStrategy

@export_group("Player Score Display")
@export var player_score_label: Label

var _player_score_label_format: String
var _player_score := 0


func _ready():
	_init_score_processing()
	_init_player_score_display()


func _init_score_processing():
	if score_strategy:
		SignalUtils.reconnect_safely(score_strategy.score_awarded, _on_score_awarded)
	else:
		push_warning("ScoreStrategy is not assigned in %s. Player score cannot be processed." % get_path())



func _init_player_score_display():
	if player_score_label:
		_player_score_label_format = player_score_label.text
	_update_player_score_label()


func _on_score_awarded(value: int):
	_player_score += value
	print_debug("%s: points added = %.f, total = %.f" % [get_path(), value, _player_score])
	_update_player_score_label()


func _update_player_score_label():
	if player_score_label:
		player_score_label.text = _player_score_label_format % _player_score
	else:
		push_warning("Cannot display player score because Label is not provided for %s." % get_path())


func _exit_tree():
	if score_strategy:
		SignalUtils.disconnect_safely(score_strategy.score_awarded, _on_score_awarded)
