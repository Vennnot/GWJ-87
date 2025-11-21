extends Node

@export_multiline var starting_text : String

func _ready() -> void:
	SceneChanger.go_to_scene("res://scenes/levels/level1/level1.tscn",  starting_text)
