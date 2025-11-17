extends Sprite2D

func _process(delta: float) -> void:
	scale = scale + Vector2.ONE *delta


func _ready() -> void:
	rotation += 50
