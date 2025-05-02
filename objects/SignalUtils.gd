class_name SignalUtils
extends Object


## Connects a [param signal_obj] to a [param callable] only if it is not already connected.
static func connect_safely(signal_obj: Signal, callable: Callable, flags: int = 0):
	if not signal_obj.is_connected(callable):
		signal_obj.connect(callable, flags)


## Disconnects a [param signal_obj] from a [param callable] only if it is currently connected.
static func disconnect_safely(signal_obj: Signal, callable: Callable):
	if signal_obj.is_connected(callable):
		signal_obj.disconnect(callable)


## Ensures the [param signal_obj] is connected only once to the given [param callable].
## Disconnects previous connection if it exists, then connects again.
static func reconnect_safely(signal_obj: Signal, callable: Callable, flags: int = 0):
	disconnect_safely(signal_obj, callable)
	connect_safely(signal_obj, callable, flags)
