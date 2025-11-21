extends CharacterBody2D
class_name Player

@export var speed := 100.0
@export var friction := 2000.0
@onready var interaction_finder: Area2D = $InteractionFinder
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite

var interacting := false :set = _set_interacting

func _set_interacting(value:bool)->void:
	interacting = value
	if interacting:
		set_physics_process(false)
	else:
		set_physics_process(true)


func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)


func _on_dialogue_started(dialogue:DialogueResource)->void:
	interacting = true


func _on_dialogue_ended(dialogue:DialogueResource)->void:
	interacting = false


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"interact"):
		Events.player_interacted.emit()
		_interact()
		return


func _interact()->void:
	var interactables := interaction_finder.get_overlapping_areas()
	if not interactables.size() > 0:
		return
		
	interactables[0].get_parent().interact()


func _physics_process(delta: float) -> void:
	var input_vector := Input.get_vector("left", "right", "up", "down")
	
	if input_vector != Vector2.ZERO:
		if not animated_sprite.is_playing():
			animated_sprite.play("walk")
		if input_vector.x > 0:
			animated_sprite.scale = Vector2.ONE
		elif input_vector.x < 0:
			animated_sprite.scale = Vector2(-1,1)
		velocity = input_vector * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction*delta)
		if not animated_sprite.animation == &"idle":
			animated_sprite.play("idle")
	
	move_and_slide()
