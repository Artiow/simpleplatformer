@tool
extends EditorToolHandler


func _apply_editor_changes():
	LevelEnter._sync_scale(owner as LevelEnter)
