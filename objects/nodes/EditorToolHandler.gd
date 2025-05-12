@tool
class_name EditorToolHandler
extends Node

@export_group("Property Monitoring", "monitored_")
## Optional custom node to monitor.
## If set, it overrides [member owner] as the monitored node.
@export var monitored_node: Node
## List of property names to monitor for changes in the editor.
@export var monitored_properties: Array[StringName] = []

var _last_hash: int


func _ready() -> void:
	if not Engine.is_editor_hint():
		_extinguish()
		return

	_init_monitored_node()
	_init_monitoring()


func _extinguish():
	set_process(false)
	queue_free()


func _init_monitored_node():
	if not monitored_node and owner is Node:
		monitored_node = owner


func _init_monitoring():
	monitored_properties = EditorToolHandler._filter_existing_properties(monitored_node, monitored_properties)
	_last_hash = EditorToolHandler._calculate_hash(monitored_node, monitored_properties)


func _process(_delta: float):
	var current_hash := EditorToolHandler._calculate_hash(monitored_node, monitored_properties)
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
