@tool
@icon("res://editor/icons/gear-white.svg")
class_name NodeEditorTool
extends Node

@export_group("Property Monitoring", "monitored_")
## Optional custom node to monitor.
## If set, it overrides [member owner] as the monitored node.
@export var monitored_node: Node:
	set(value):
		monitored_node = value
		_reset_monitoring()
## List of property names to monitor for changes in the editor.
@export var monitored_properties: Array[StringName]:
	set(value):
		monitored_properties = value
		_reset_monitoring()

var _monitored_node: Node
var _monitored_properties: Array[StringName]
var _last_hash: int


func _ready() -> void:
	if not Engine.is_editor_hint():
		_extinguish()
		return

	_reset_monitoring()
	_apply_editor_changes(_monitored_node)


func _extinguish():
	set_process(false)
	queue_free()


func _reset_monitoring():
	_monitored_node = monitored_node if monitored_node else owner
	_monitored_properties = NodeEditorTool._filter_existing_properties(_monitored_node, _fetch_monitored_properties())
	_last_hash = NodeEditorTool._calculate_hash(_monitored_node, _monitored_properties)


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
		_apply_editor_changes(_monitored_node)


func _apply_editor_changes(_node: Node):
	pass # override to implement custom logic


static func _calculate_hash(node: Node, property_name_array: Array[StringName]) -> int:
	if node == null or property_name_array.is_empty():
		return 0

	var result := 0
	for property_name in property_name_array:
		result = 31 * result + hash(node.get(property_name))

	return result


static func _filter_existing_properties(node: Node, property_name_array: Array[StringName]) -> Array[StringName]:
	if node == null or property_name_array.is_empty():
		return []

	var property_name_set: Dictionary[StringName, bool] = {}
	for property in node.get_property_list():
		property_name_set[property.name] = true

	var result: Array[StringName] = []
	for property_name in property_name_array:
		if property_name_set.erase(property_name):
			result.append(property_name)

	return result
