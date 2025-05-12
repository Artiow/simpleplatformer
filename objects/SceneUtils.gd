class_name SceneUtils
extends Object

## Searches for a single child node of the given [param type] in the node tree of [param node].
## If multiple nodes are found, a warning is logged and the first one is returned.
## Returns [code]null[/code] if none is found.
static func find_singleton_child_in(node: Node, type: StringName, recursive: bool = true, owned: bool = true) -> Node:
	var candidates := node.find_children("*", type, recursive, owned)
	if candidates.is_empty():
		push_error("No %s found in the node tree of %s." % [type, node.get_path()])
		return null
	if candidates.size() > 1:
		push_warning("Multiple %s nodes found in the node tree of %s. Using the first one %s." % [type, node.get_path(), candidates[0].get_path()])
	return candidates[0]


## Attaches the given [param node] as a child of [param parent] and sets its owner to [param parent].
## This is useful when dynamically adding a node that should be part of the scene tree and saved with it.
static func attach_node_to(node: Node, parent: Node):
	parent.add_child(node)
	node.set_owner(parent)


## Detaches the given [param node] from its [param parent] and clears its owner.
## This can be used to safely remove a node from the scene tree without freeing it yet.
static func detach_node_from(node: Node, parent: Node):
	if node.get_parent() == parent:
		node.set_owner(null)
		parent.remove_child(node)


## Frees the given [param node] after detaching it from its [param parent].
## Combines [method detach_node_from] and [method queue_free] to safely remove and delete a node.
static func free_node_from(node: Node, parent: Node):
	detach_node_from(node, parent)
	node.queue_free()
