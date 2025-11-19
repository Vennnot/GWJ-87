@tool
class_name Entity
extends Node2D

signal interacted

@export_category("Visuals")
@export var texture : Texture :
	set(value):
		texture = value
		if not sprite:
			return
		if texture:
			sprite.texture = value
		else: 
			sprite.texture = null
@export var sprite_frames : SpriteFrames


@export_category("Collider")
@export var collider : CollisionShape2D


@export_category("Interaction")
@export var dialogue_resource : DialogueResource
@export var interactable_collider : CollisionShape2D

@export_category("Level Transition")
@export var level_transition : bool = false

@export_category("Decayable")
@export var decay_palette : Texture



@onready var static_body: StaticBody2D = %StaticBody
@onready var sprite: Sprite2D = %Sprite
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var interactable_area: Area2D = %InteractableArea
@onready var interactable_sprite: Sprite2D = %InteractableSprite

func _ready() -> void:
	if texture:
		sprite.texture = texture
	else:
		sprite.texture = null
	
	if sprite_frames:
		sprite.hide()
		animated_sprite.show()
		animated_sprite.sprite_frames = sprite_frames
		animated_sprite.play(&"default")
	
	if collider:
		static_body.show()
		collider.reparent(static_body)
	
	if interactable_collider:
		interactable_sprite.show()
		interactable_collider.reparent(interactable_area)
		interactable_area.area_entered.connect(_on_area_entered)
		interactable_area.area_exited.connect(_on_area_exited)


func interact():
	if dialogue_resource:
		DialogueManager.show_dialogue_balloon(dialogue_resource,"start")
	interacted.emit()


func _on_area_entered(other_area:Area2D)->void:
	interactable_sprite.show()


func _on_area_exited(other_area:Area2D)->void:
	interactable_sprite.hide()
