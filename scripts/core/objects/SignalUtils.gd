class_name SignalUtils
extends Object

## Connects a [param signal_obj] to a [param callable] only if it is not already connected.
static func connect_safely(signal_obj: Signal, callable: Callable, flags: int = 0):
	if not signal_obj.is_connected(callable):
		signal_obj.connect(callable, flags)
		print_debug("Signal \"%s\" sucsessfully connected to callable \"%s\"" % [signal_obj.get_name(), callable.get_method()])


## Disconnects a [param signal_obj] from a [param callable] only if it is currently connected.
static func disconnect_safely(signal_obj: Signal, callable: Callable):
	if signal_obj.is_connected(callable):
		signal_obj.disconnect(callable)
		print_debug("Signal \"%s\" sucsessfully disconnected from callable \"%s\"" % [signal_obj.get_name(), callable.get_method()])


## Ensures the [param signal_obj] is connected only once to the given [param callable].
## Disconnects previous connection if it exists, then connects again.
static func reconnect_safely(signal_obj: Signal, callable: Callable, flags: int = 0):
	disconnect_safely(signal_obj, callable)
	connect_safely(signal_obj, callable, flags)


## Disconnects all callables currently connected to the given [param signal_obj] safely.
## Iterates through all connections and disconnects each one if it is currently connected.
static func disconnect_all_safely(signal_obj: Signal):
	for connection in signal_obj.get_connections():
		disconnect_safely(signal_obj, connection[&"callable"])
