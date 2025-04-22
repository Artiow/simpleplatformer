extends Level2D

@onready var player_score_label: Label = $Labels/PlayerScoreLabel

var _player_score_label_format: String


func _on_player_score_update():
	if player_score_label:
		if not _player_score_label_format:
			_player_score_label_format = player_score_label.text
		player_score_label.text = _player_score_label_format % _player_score
