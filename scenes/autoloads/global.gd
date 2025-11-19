extends Node

const PLAYER_SCENE : PackedScene = preload("res://scenes/player/player.tscn")

var favor : float = 0


func change_favor(value:int)->void:
	favor += value
	print("Changed favor!")
