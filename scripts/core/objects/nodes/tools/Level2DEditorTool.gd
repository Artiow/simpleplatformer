@tool
class_name Level2DEditorTool
extends NodeEditorTool

const _DEFAULT_PROPERTIES: Array[StringName] = [&"border_bottom", &"border_left", &"border_right", &"border_top"]

@export_group("Debug Border Style", "border_")
@export var border_color := Color(1.0, 0.6, 0.7, 0.4):
	set(value):
		border_color = value
		_redraw_overlay()
@export var border_width := 3.0:
	set(value):
		border_width = value
		_redraw_overlay()

var _level2d: Level2D
var _overlay: CanvasItem


func _reset_monitoring():
	super._reset_monitoring()
	_init_overlay_if_needed()


func _init_overlay_if_needed():
	if not _overlay:
		_overlay = CanvasUtils.create_overlay_canvas(_level2d, _on_overlay_draw)
	elif _overlay.owner != _level2d:
		push_warning("Overlay owner mismatch: expected %s, but got %s. Overlay will be recreated." % [_level2d.get_path(), _overlay.owner if _overlay.owner else "null"])
		SceneUtils.free_node(_overlay)
		_overlay = CanvasUtils.create_overlay_canvas(_level2d, _on_overlay_draw)


func _redraw_overlay():
	if _overlay:
		_overlay.queue_redraw()
	else:
		push_error("Overlay is not initialized yet, cannot redraw.")


func _default_monitored_properties() -> Array[StringName]:
	return _DEFAULT_PROPERTIES


func _apply_editor_changes(node: Node):
	if node is Level2D:
		_level2d = node as Level2D
	else:
		_level2d = null
		push_error("Monitored node must be of type Level2D. Cannot use %s with %s" % [self.get_path(), node.get_path()])

	_redraw_overlay()


func _on_overlay_draw(canvas: CanvasItem):
	if _level2d:
		var border_position := Vector2(_level2d.border_left, _level2d.border_top)
		var border_size := Vector2(_level2d.border_right - _level2d.border_left, _level2d.border_bottom - _level2d.border_top)
		canvas.draw_rect(Rect2(border_position, border_size), border_color, false, border_width)
