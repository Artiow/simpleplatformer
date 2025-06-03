@tool
class_name Level2DEditorTool
extends NodeEditorTool

const DEFAULT_PROPERTIES: Array[StringName] = [&"border_bottom", &"border_left", &"border_right", &"border_top"]

@export_group("Debug Border Style", "border_")
@export var border_color := Color(1.0, 0.6, 0.7, 0.4):
	set(value):
		border_color = value
		overlay.queue_redraw()
@export var border_width := 3.0:
	set(value):
		border_width = value
		overlay.queue_redraw()

var overlay: CanvasItem


func _reset_monitoring():
	super._reset_monitoring()
	_init_overlay_if_needed()


func _init_overlay_if_needed():
	if not overlay:
		overlay = CanvasUtils.attach_overlay_canvas_to(self, _on_overlay_draw)


func _default_monitored_properties() -> Array[StringName]:
	return DEFAULT_PROPERTIES


func _apply_editor_changes(_node: Node):
	overlay.queue_redraw()


func _on_overlay_draw(canvas: CanvasItem):
	var level2d := _monitored_node as Level2D
	var border_position := Vector2(level2d.border_left, level2d.border_top)
	var border_size := Vector2(level2d.border_right - level2d.border_left, level2d.border_bottom - level2d.border_top)
	canvas.draw_rect(Rect2(border_position, border_size), border_color, false, border_width)
