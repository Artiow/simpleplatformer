@tool
class_name Level2DEditorTool
extends Node2DEditorTool

const _DEFAULT_PROPERTIES: Array[StringName] = [&"border_bottom", &"border_left", &"border_right", &"border_top"]

@export_group("Debug Border Style", "border_")
@export var border_color := Color(1.0, 0.6, 0.7, 0.4):
	set(value):
		border_color = value
		redraw_overlay()
@export var border_width := 3.0:
	set(value):
		border_width = value
		redraw_overlay()


func _default_monitored_properties() -> Array[StringName]:
	return _DEFAULT_PROPERTIES


func _draw_overlay(node: Node, canvas: CanvasItem):
	if node is Level2D:
		var level2d := node as Level2D
		var border_position := Vector2(level2d.border_left, level2d.border_top)
		var border_size := Vector2(level2d.border_right - level2d.border_left, level2d.border_bottom - level2d.border_top)
		canvas.draw_rect(Rect2(border_position, border_size), border_color, false, border_width)
