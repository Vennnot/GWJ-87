extends CanvasLayer

@onready var color_rect: ColorRect = %TransitionShader
@onready var scene_text: Label = %SceneText


func go_to_scene(scene:String="", end_scene_text:String=""):
	await darken()
	scene_text.text = end_scene_text
	if end_scene_text:
		await animate_text()
		await Events.player_interacted
	get_tree().change_scene_to_file(scene)
	await undarken()


func darken()->void:
	var tween := create_tween()
	tween.tween_property(color_rect,"material:shader_parameter/progress",1,0.5)
	await tween.step_finished


func undarken()->void:
	var tween := create_tween()
	tween.tween_property(scene_text,"visible_ratio",0,1)
	tween.chain().tween_property(color_rect,"material:shader_parameter/progress",0,0.5)
	await tween.step_finished


func animate_text()->void:
	var tween := create_tween()
	tween.tween_property(scene_text,"visible_ratio",1,1)
	await tween.step_finished
