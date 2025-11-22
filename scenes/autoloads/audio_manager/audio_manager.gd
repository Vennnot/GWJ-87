extends Node

@export_category("Audio Files")
@export var audio_library: Dictionary = {
	"interaction": preload("uid://ceg1f3wu0suxq"),
	"transition":preload("uid://brrqrhgr4ghic"),
	
	# SFX - Arrays (multiple variations)

	"typing":[preload("uid://cwa4vxcwvm3xk"), preload("uid://6la2wp2i4os3"), preload("uid://cqc2dh0f5rvtx"), preload("uid://bl0coci0xvx5r"), preload("uid://c2vl72pr5qp01"), preload("uid://e1qvjm0cokpr")],
}

@export_category("Music")
@export var music_library: Dictionary = {
	"default":preload("uid://c4nja6bv82o6o"),
	"ending":preload("uid://db0qrwfctldfw")
}

@onready var current_music: AudioStreamPlayer = %CurrentMusic

@export var crossfade_time := 0.1

func _ready():
	play("default","music")

func play(sound: String, sound_bus: String = "sfx"):
	if sound_bus == "sfx":
		var audio_player := AudioStreamPlayer.new()
		add_child(audio_player)
		audio_player.stream = _fetch_audio(sound)
		#audio_player.bus = sound_bus
		audio_player.play(0.0)
		audio_player.pitch_scale += randf_range(-0.05, 0.05)
		if sound == "item_abandoned":
			audio_player.volume_db = -5
		await audio_player.finished
		audio_player.queue_free()
	elif sound_bus == "music":
		current_music.stream = _fetch_audio(sound, true)
		fade_in()

func _fetch_audio(sound: String, is_music: bool = false) -> AudioStream:
	var library = music_library if is_music else audio_library
	var audio = library.get(sound)
	
	if audio is Array:
		return audio.pick_random() if not audio.is_empty() else null
	return audio

func fade_in(duration: float = 0.5):
	current_music.volume_db = -40
	current_music.play()
	var tween = create_tween()
	tween.tween_property(current_music, "volume_db", 0, duration)

func fade_out(duration: float = 3.0):
	var tween = create_tween()
	tween.tween_property(current_music, "volume_db", -80, duration)
	await tween.finished
	current_music.stop()
