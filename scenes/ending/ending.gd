class_name Ending
extends Control


@onready var texture: TextureRect = %Texture
@onready var label: Label = %Label

@export var good_ending_text_array : PackedStringArray
@export var neutral_ending_text_array : PackedStringArray
@export var bad_ending_text_array : PackedStringArray

var ending_array : PackedStringArray
var count := -1

func _ready() -> void:
	Events.player_interacted.connect(_interact)
	if Global.favor > 0:
		_good_ending()
	elif Global.favor < 0:
		_bad_ending()
	else:
		_neutral_ending()
	tween_text()


func _neutral_ending()->void:
	texture.texture = null
	ending_array = neutral_ending_text_array


func _good_ending()->void:
	texture.texture = null
	ending_array = good_ending_text_array


func _bad_ending()->void:
	texture.texture = null
	ending_array = bad_ending_text_array


func tween_text()->void:
	var tween := create_tween()
	tween.tween_property(label,"visible_ratio",0,1)


func _interact():
	if count >= ending_array.size():
		_ending()
		return
	count+=1
	label.text = ending_array[count]


func _ending():
	label.text = "The end! \n
	Thank you for playing"
