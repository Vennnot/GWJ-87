class_name Interactable
extends Node2D

@onready var sprite: Sprite2D = %Sprite
@onready var interactable_area: Area2D = %InteractableArea
@onready var interactable_sprite: Sprite2D = %InteractableSprite

@export var dialogue_resource : DialogueResource
@export var dialogue_start := "start"

var player_in_range := false


func _ready() -> void:
	interactable_area.area_entered.connect(_on_area_entered)
	interactable_area.area_exited.connect(_on_area_exited)


func interact()->void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource,dialogue_start)


func _on_area_entered(other_area:Area2D)->void:
	player_in_range = true
	interactable_sprite.show()


func _on_area_exited(other_area:Area2D)->void:
	player_in_range = false
	interactable_sprite.hide()
