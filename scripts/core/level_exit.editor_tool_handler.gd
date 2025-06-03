@tool
extends NodeEditorTool


func _apply_editor_changes(node: Node):
	LevelExit._sync_scale(node as LevelExit)
