extends Node2D


func _ready():
	MusicManager.play_main_theme()
	SceneLoader.goto_scene("Title")
