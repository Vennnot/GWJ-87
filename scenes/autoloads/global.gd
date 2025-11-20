extends Node

const PLAYER_SCENE : PackedScene = preload("res://scenes/player/player.tscn")

var neutral_color := Color.WHITE
var mother_color := Color.GREEN
var osmomancer_color := Color.BLUE

var favor : float = 0


func change_favor(value:int)->void:
	favor += value
	print("Changed favor!")
