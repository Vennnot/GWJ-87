extends CharacterBody2D
class_name Player

@export var speed := 100.0
@export var friction := 2000.0


func _process(delta: float) -> void:
	if Input.is_action_just_pressed(&"interact"):
		Events.player_interacted.emit()


func _physics_process(delta:float)->void:
	var input_vector := Input.get_vector("left", "right", "up", "down")
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()
