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
			sprite.show()
			sprite.texture = value
		else: 
			sprite.texture = null

@export var sprite_frames : SpriteFrames :
	set(value):
		sprite_frames = value
		if not animated_sprite:
			return
		if sprite_frames:
			sprite.hide()
			animated_sprite.show()
			animated_sprite.sprite_frames = value
			animated_sprite.play(&"default")
		else: 
			animated_sprite.sprite_frames = null


@export_category("Physics")
@export var collider : CollisionShape2D


@export_category("Interaction")
@export var dialogue : DialogueResource
@export var area_collider : CollisionShape2D

@export_category("Level Transition")
@export var level_transition : bool = false

@export_category("Decayable")
@export var decay_palette : Texture



@onready var static_body: StaticBody2D = %StaticBody
@onready var sprite: Sprite2D = %Sprite
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var interactable_area: Area2D = %InteractableArea
@onready var interactable_sprite: Sprite2D = %InteractableSprite
@onready var point_light: PointLight2D = %PointLight

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
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
	
	if area_collider:
		interactable_sprite.show()
		area_collider.reparent(interactable_area)
		interactable_area.area_entered.connect(_on_area_entered)
		interactable_area.area_exited.connect(_on_area_exited)
	
	if dialogue:
		point_light.show()
		tween_light()


func tween_light():
	var tween :Tween= create_tween()
	tween.tween_property(point_light,^"energy",0.3,0.8)
	tween.chain().tween_property(point_light,^"energy",0,0.8)
	await tween.finished
	tween_light()

func interact():
	if dialogue:
		DialogueManager.show_dialogue_balloon(dialogue,"start")
	interacted.emit()


func _on_area_entered(other_area:Area2D)->void:
	interactable_sprite.show()


func _on_area_exited(other_area:Area2D)->void:
	interactable_sprite.hide()
