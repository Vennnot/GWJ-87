class_name Ending
extends Control


@onready var texture: TextureRect = %Texture
@onready var label: Label = %Label
@onready var ending_label: Label = %EndingLabel
@onready var portraits: HBoxContainer = %Portraits

@export var good_ending_text_array : PackedStringArray
@export var neutral_ending_text_array : PackedStringArray
@export var bad_ending_text_array : PackedStringArray

var ending_array : PackedStringArray
var count := -1

func _ready() -> void:
	portraits.hide()
	AudioManager.play("ending","music")
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
	tween.tween_property(ending_label,"visible_ratio",1,0.5)


func _interact():
	if count >= ending_array.size()-1:
		_ending()
		return
	
	count+=1
	ending_label.text = ending_array[count]


func _ending():
	portraits.show()
	ending_label.text = ""
	label.text = "The end! \n
	Thank you for playing"
