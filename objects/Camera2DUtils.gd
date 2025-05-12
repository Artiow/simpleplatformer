class_name Camera2DUtils
extends Object

## Attaches the given [param camera2d] as a child of [param parent] and sets its owner to [param parent].
## Resets [param camera2d] position to (0, 0) and resets smoothing.
static func attach_camera_to(camera2d: Camera2D, parent: Node):
	SceneUtils.attach_node_to(camera2d, parent)
	camera2d.position = Vector2(0, 0)
	camera2d.reset_smoothing()
