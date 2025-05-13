## Schedules a callback after a specified number of physics frames.
## Works similarly to [Timer] but measures physics frames instead of real time.
class_name PhysicsFrameScheduler
extends Node

## Number of physics frames to wait before emitting [signal timeout].
@export var wait_frames := 1
## If [code]true[/code], the node will queue_free itself after emitting [signal timeout].
@export var autodelete := true

## Emitted after the specified number of physics frames have elapsed.
signal timeout()

var _frames_left := 0


func _ready():
	set_physics_process(false)


func _physics_process(_delta: float):
	if _frames_left > 0:
		_frames_left -= 1
	else:
		_emit_timeout()


## Starts the scheduler.
## If [param frames] is specified and greater than zero, it overrides [member wait_frames].
func start(frames: int = 0) -> void:
	if _frames_left > 0:
		push_warning("%s is already running!" % get_path())
		return

	_frames_left = frames if frames > 0 else wait_frames
	set_physics_process(true)


func _emit_timeout():
	set_physics_process(false)
	timeout.emit()
	if autodelete:
		queue_free()


## Starts a one-shot scheduler that automatically deletes itself after completion.
## [param parent]: The node to attach the scheduler to.
## [param callback]: The function to call when finished.
## [param frames]: How many physics frames to wait before calling the callback.
static func start_one_shot(parent: Node, callback: Callable, frames: int = 1):
	var scheduler := PhysicsFrameScheduler.new()
	SceneUtils.attach_node_to(scheduler, parent)
	SignalUtils.connect_safely(scheduler.timeout, callback, CONNECT_ONE_SHOT)
	scheduler.start(frames)
