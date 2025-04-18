class_name FormatLabel
extends Label

var _format_text: String


func _ready():
	_format_text = text


func format(args: Array[Variant]):
	text = _format_text % args
