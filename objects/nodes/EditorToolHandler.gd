@tool
@icon("res://icons/EditorToolHandler.svg")
class_name EditorToolHandler
extends Node

@export_group("Property Monitoring", "monitored_")
## Optional custom node to monitor.
## If set, it overrides [member owner] as the monitored node.
@export var monitored_node: Node:
	set(value):
		monitored_node = value
		_init_monitoring()
## List of property names to monitor for changes in the editor.
@export var monitored_properties: Array[StringName]:
	set(value):
		monitored_properties = value
		_init_monitoring()

var _monitored_node: Node
var _monitored_properties: Array[StringName]
var _last_hash: int


func _ready() -> void:
	if not Engine.is_editor_hint():
		_extinguish()
		return

	_init_monitoring()


func _extinguish():
	set_process(false)
	queue_free()


func _init_monitoring():
	_monitored_node = monitored_node if monitored_node else owner
	_monitored_properties = EditorToolHandler._filter_existing_properties(_monitored_node, monitored_properties)
	_last_hash = EditorToolHandler._calculate_hash(_monitored_node, _monitored_properties)


func _process(_delta: float):
	var current_hash := EditorToolHandler._calculate_hash(_monitored_node, _monitored_properties)
	if current_hash != _last_hash:
		_last_hash = current_hash
		_apply_editor_changes()


func _apply_editor_changes():
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
