extends CanvasLayer

@onready var color_rect: ColorRect = %ColorRect

func go_to_scene(scene:String=""):
	await darken()
	# Dialogue would go here
	await undarken()
	get_tree().change_scene_to_file(scene)


func darken()->void:
	var tween := create_tween()
	tween.tween_property(color_rect,"material:shader_parameter/progress",1,0.5)
	await tween.step_finished

func undarken()->void:
	var tween := create_tween()
	tween.tween_property(color_rect,"material:shader_parameter/progress",0,0.5)
	await tween.step_finished
