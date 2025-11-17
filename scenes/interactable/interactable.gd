class_name Interactable
extends Node2D

@onready var sprite: Sprite2D = %Sprite
@onready var interactable_area: Area2D = %InteractableArea
@onready var interactable_sprite: Sprite2D = %InteractableSprite

var player_in_range := false

func _ready() -> void:
	interactable_area.body_entered.connect(_on_body_entered)
	interactable_area.body_exited.connect(_on_body_exited)


func _on_body_entered(other_body:Node2D)->void:
	player_in_range = true
	interactable_sprite.show()


func _on_body_exited(other_body:Node2D)->void:
	player_in_range = false
	interactable_sprite.hide()
