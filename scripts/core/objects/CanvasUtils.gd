class_name CanvasUtils
extends Object


static func attach_overlay_canvas_to(parent: Node, on_overlay_draw: Callable) -> CanvasItem:
	var overlay := Node2D.new()
	SceneUtils.attach_node_to(overlay, parent)
	SignalUtils.connect_safely(overlay.draw, on_overlay_draw.bindv([overlay]))
	overlay.queue_redraw()
	return overlay
