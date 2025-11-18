class_name LevelScene
extends Node2D

@export var next_level_info : LevelInfo
@onready var level_transition_interactable: LevelTransitionInteractable = %LevelTransitionInteractable

func _ready() -> void:
	if not next_level_info:
		level_transition_interactable.queue_free()
		print("This is the last level!")
		return
	
	level_transition_interactable.interacted.connect(_on_interacted)


func _on_interacted()->void:
	SceneChanger.go_to_scene(next_level_info.next_scene_file, next_level_info.end_scene_text)
