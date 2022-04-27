extends Node2D

onready var musicManager = $MusicManager


func _ready():
	musicManager.play_main_theme()
