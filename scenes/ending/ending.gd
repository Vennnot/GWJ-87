class_name Ending
extends Control


@onready var texture: TextureRect = %Texture
@onready var label: Label = %Label


func _ready() -> void:
	if Global.favor > 0:
		_good_ending()
	elif Global.favor < 0:
		_bad_ending()
	else:
		_neutral_ending()
	tween_text()


func _neutral_ending()->void:
	texture.texture = null
	label.text = ""


func _good_ending()->void:
	texture.texture = null
	label.text = ""


func _bad_ending()->void:
	texture.texture = null
	label.text = ""


func tween_text()->void:
	var tween := create_tween()
	tween.tween_property(label,"visible_ratio",0,1)
