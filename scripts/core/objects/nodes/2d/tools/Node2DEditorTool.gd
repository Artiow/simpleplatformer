@tool
@icon("res://assets/editor/icons/gear-blue-skyblue.svg")
class_name Node2DEditorTool
extends Node2D

@export_group("Property Monitoring", "monitored_")
## Optional custom node to monitor.
## If set, it overrides [member owner] as the monitored node.
@export var monitored_node: Node2D:
	set(value):
		monitored_node = value
		_reset.call_deferred()
## List of property names to monitor for changes in the editor.
@export var monitored_properties: Array[StringName]:
	set(value):
		monitored_properties = value
		_reset.call_deferred()

@export_group("Overlay Canvas", "overlay_")
@export var overlay_enabled: bool = false:
	set(value):
		overlay_enabled = value
		queue_redraw()

var _monitored_node: Node2D
var _monitored_properties: Array[StringName]
var _last_hash := 0


func _ready():
	if not Engine.is_editor_hint():
		_extinguish()
	else:
		_reset.call_deferred()


func _extinguish():
	set_process(false)
	queue_free()


func _reset():
	_reset_monitoring()


func _reset_monitoring():
	_monitored_node = monitored_node if monitored_node else owner
	_monitored_properties = NodeEditorTool._filter_existing_properties(_monitored_node, _fetch_monitored_properties())


func _fetch_monitored_properties() -> Array[StringName]:
	var result := monitored_properties.duplicate()
	result.append_array(_default_monitored_properties())
	return result


func _default_monitored_properties() -> Array[StringName]:
	return [] # override to implement custom logic


func _process(_delta: float):
	var current_hash := NodeEditorTool._calculate_hash(_monitored_node, _monitored_properties)
	if current_hash != _last_hash:
		_last_hash = current_hash
		queue_apply_editor_changes()


func queue_apply_editor_changes():
	_apply_editor_changes_and_redraw.call_deferred()


func _apply_editor_changes_and_redraw():
	if _monitored_node:
		_apply_editor_changes(_monitored_node)

	queue_redraw()


func _apply_editor_changes(_node: Node2D):
	pass # override to implement custom logic


func _draw():
	if overlay_enabled and _monitored_node:
		_draw_overlay(_monitored_node, self)	


func _draw_overlay(_node: Node2D, _canvas: CanvasItem):
	pass # override to implement custom logic
