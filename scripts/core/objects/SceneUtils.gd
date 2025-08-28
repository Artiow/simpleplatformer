class_name SceneUtils
extends Object


## Searches for child nodes of the given [param type] within the node tree of [param node].
static func find_children_in(node: Node, type: StringName, recursive: bool = false, owned: bool = true) -> Array[Node]:
	return node.find_children("*", type, recursive, owned)


## Searches for a single child node of the given [param type] within the node tree of [param node].
## If multiple nodes are found, a warning is logged and the first one is returned.
## Returns [code]null[/code] if none is found.
static func find_singleton_child_in(node: Node, type: StringName, recursive: bool = false, owned: bool = true) -> Node:
	var candidates := find_children_in(node, type, recursive, owned)
	if candidates.is_empty():
		push_error("No %s found in the node tree of %s." % [type, node.get_path()])
		return null
	if candidates.size() > 1:
		push_warning("Multiple %s nodes found in the node tree of %s. Using the first one %s." % [type, node.get_path(), candidates[0].get_path()])
	return candidates[0]


## Attaches the given [param node] as a child of [param parent] and sets its owner to [param parent].
## If [param internal] is different than [constant Node.INTERNAL_MODE_DISABLED], the child will be added as internal node.
## This is useful when dynamically adding a node that should be part of the scene tree and saved with it.
static func attach_node_to(node: Node, parent: Node, internal: int = 0) -> void:
	if not node:
		push_error("Node to attach is null.")
		return
	if not parent:
		push_error("Parent node to attach to is null.")
		return

	var existed_parent := node.get_parent()
	if existed_parent:
		if existed_parent == parent:
			push_warning("Node is already a child of the specified parent.")
		else:
			push_error("Node is already a child of an another node.")
		return

	parent.add_child(node, false, internal)
	node.set_owner(parent)


## Detaches the given [param node] from its parent and clears its owner.
## This can be used to safely remove a node from the scene tree without freeing it yet.
static func detach_node(node: Node) -> void:
	if not node:
		push_error("Node to detach is null.")
		return

	var parent := node.get_parent()
	if not parent:
		push_warning("Node is already detached.")
		return

	node.set_owner(null)
	parent.remove_child(node)


## Frees the given [param node] after detaching it from its parent.
## Combines [method detach_node] and [method Node.queue_free] to safely remove and delete a node.
static func free_node(node: Node):
	detach_node(node)
	if node: node.queue_free()
