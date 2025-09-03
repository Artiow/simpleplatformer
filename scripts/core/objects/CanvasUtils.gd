class_name CanvasUtils
extends Object


## Creates a [CanvasItem] overlay and connects its [signal CanvasItem.draw] to [param on_overlay_draw].
## The [param on_overlay_draw] callback must accept one argument: the overlay node (of type [CanvasItem]).
static func create_overlay_canvas(target: Node, on_overlay_draw: Callable, name: StringName = &"OverlayCanvas", z_index: int = 4096) -> CanvasItem:
	if not target:
		push_error("Target node must be not null.")
		return null
	if not on_overlay_draw or not on_overlay_draw.is_valid() or on_overlay_draw.get_argument_count() != 1:
		push_error("Invalid draw callback: expected a valid Callable with one argument (CanvasItem).")
		return null

	var overlay: CanvasItem = Node2D.new()
	SceneUtils.attach_node_to(overlay, target, Node.INTERNAL_MODE_BACK)
	SignalUtils.connect_safely(overlay.draw, on_overlay_draw.bindv([overlay]))
	overlay.owner = target
	overlay.name = name
	overlay.z_index = z_index
	overlay.queue_redraw()
	return overlay


## Ensures that the given [param overlay] canvas is correctly attached to [param target].
## If the overlay is not already a child of the target or its owner, it will be reattached.
static func ensure_overlay_canvas_target(overlay: CanvasItem, target: Node) -> CanvasItem:
	if not overlay:
		push_error("Overlay must be not null.")
		return null
	if not target:
		push_error("Target node must be not null.")
		return null

	var overlay_parent := overlay.get_parent()
	if overlay_parent != target or overlay.owner != target or overlay_parent != overlay.owner:
		if overlay_parent != target:
			SceneUtils.detach_node(overlay)
			SceneUtils.attach_node_to(target, overlay, Node.INTERNAL_MODE_BACK)
		overlay.owner = target

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
