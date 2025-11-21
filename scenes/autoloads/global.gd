extends Node

const PLAYER_SCENE : PackedScene = preload("res://scenes/player/player.tscn")

var neutral_color := Color.WHITE
var mother_color := Color.GREEN
var osmomancer_color := Color.BLUE

var favor : int = 100


func change_favor(value:int)->void:
	favor += value
	print("Changed favor!")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"interact"):
		Events.player_interacted.emit()
