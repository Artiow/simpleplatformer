@tool
extends EditorToolHandler


func _apply_editor_changes():
	LevelExit._sync_scale(owner as LevelExit)
