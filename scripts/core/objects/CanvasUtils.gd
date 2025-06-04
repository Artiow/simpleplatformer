class_name CanvasUtils
extends Object


## Creates a [CanvasItem] overlay and connects its [signal Node.draw] to [param on_overlay_draw].
## The [param on_overlay_draw] callback must accept one argument: the overlay node (of type [CanvasItem]).
static func create_overlay_canvas(parent: Node, on_overlay_draw: Callable, name: StringName = &"OverlayCanvas", z_index: int = 4096) -> CanvasItem:
	if not parent:
		push_error("Parent must be not null.")
		return null
	if not on_overlay_draw or not on_overlay_draw.is_valid() or on_overlay_draw.get_argument_count() != 1:
		push_error("Invalid draw callback: expected a valid Callable with one argument (CanvasItem).")
		return null

	var overlay := Node2D.new()
	SceneUtils.attach_node_to(overlay, parent)
	SignalUtils.connect_safely(overlay.draw, on_overlay_draw.bindv([overlay]))
	overlay.name = name
	overlay.z_index = z_index
	overlay.queue_redraw()
	return overlay
