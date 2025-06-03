@tool
extends NodeEditorTool


func _apply_editor_changes(node: Node):
	LevelEnter._sync_scale(node as LevelEnter)
