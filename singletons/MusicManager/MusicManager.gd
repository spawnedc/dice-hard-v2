extends Node

onready var player = $Player


func play_music(music_res):
	var stream = load(music_res)
	player.stream = stream
	player.play()


func play_main_theme():
	play_music("res://assets/music/DiceHard.ogg")


func pause():
	player.playing = false


func resume():
	player.playing = true
