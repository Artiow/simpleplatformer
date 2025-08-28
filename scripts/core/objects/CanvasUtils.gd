class_name CanvasUtils
extends Object


## Creates a [CanvasItem] overlay and connects its [signal CanvasItem.draw] to [param on_overlay_draw].
## The [param on_overlay_draw] callback must accept one argument: the overlay node (of type [CanvasItem]).
static func create_overlay_canvas(parent: Node, on_overlay_draw: Callable, name: StringName = &"OverlayCanvas", z_index: int = 4096) -> CanvasItem:
	if not parent:
		push_error("Parent must be not null.")
		return null
	if not on_overlay_draw or not on_overlay_draw.is_valid() or on_overlay_draw.get_argument_count() != 1:
		push_error("Invalid draw callback: expected a valid Callable with one argument (CanvasItem).")
		return null

	var overlay: CanvasItem = Node2D.new()
	SceneUtils.attach_node_to(overlay, parent, Node.INTERNAL_MODE_BACK)
	SignalUtils.connect_safely(overlay.draw, on_overlay_draw.bindv([overlay]))
	overlay.name = name
	overlay.z_index = z_index
	overlay.queue_redraw()
	return overlay


## Safely frees the given [param overlay] canvas.
## Disconnects all handlers from its [signal CanvasItem.draw] and removes the overlay from the scene tree.
static func free_overlay_canvas(overlay: CanvasItem) -> void:
	if not overlay:
		push_warning("Attempted to free a null overlay.")
		return

	SignalUtils.disconnect_all_safely(overlay.draw)
	SceneUtils.free_node(overlay)
