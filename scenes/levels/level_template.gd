class_name LevelScene
extends Node2D


@export var level_info : LevelInfo

@onready var level_transition_interactable: LevelTransitionInteractable = %LevelTransitionInteractable
@onready var player_start_position: Marker2D = %PlayerStartPosition

func _ready() -> void:
	instantiate_player()
	if not level_info:
		level_transition_interactable.queue_free()
		print("This is the last level!")
		return
	
	level_transition_interactable.interacted.connect(_on_interacted)


func _on_interacted()->void:
	SceneChanger.go_to_scene(level_info.next_scene_file, level_info.end_scene_text)


func instantiate_player()->void:
	var player := Global.PLAYER_SCENE.instantiate()
	add_child(player)
	player.global_position = player_start_position.global_position
