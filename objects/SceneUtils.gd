class_name SceneUtils
extends Object

## Searches for a single child node of the given [param type] in the node tree of [param node].
## If multiple nodes are found, a warning is logged and the first one is returned.
## Returns [code]null[/code] if none is found.
static func find_singleton_child_in(node: Node, type: StringName, recursive: bool = true, owned: bool = true) -> Node:
	var candidates := node.find_children("*", type, recursive, owned)
	if candidates.is_empty():
		push_error("No %s found in the node tree of %s." % [type, node])
		return null
	if candidates.size() > 1:
		push_warning("Multiple %s nodes found in the node tree of %s. Using the first one %s." % [type, node, candidates[0]])
	return candidates[0]
