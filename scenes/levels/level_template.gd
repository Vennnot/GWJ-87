class_name LevelScene
extends Node2D


@export var level_info : LevelInfo
@export var level_transition_interactable: Entity


@onready var player_start_position: Marker2D = %PlayerStartPosition
@onready var entities: Node2D = $Entities

func _ready() -> void:
	instantiate_player()
	Events.free_scene.connect(queue_free)
	if not level_info:
		print("This is the last level!")
		return
	
	if level_transition_interactable:
		level_transition_interactable.interacted.connect(_on_interacted)


func _on_interacted()->void:
	SceneChanger.go_to_scene(level_info.next_scene_file, level_info.end_scene_text)

func instantiate_player()->void:
	var player := Global.PLAYER_SCENE.instantiate()
	entities.add_child(player)
	player.global_position = player_start_position.global_position
