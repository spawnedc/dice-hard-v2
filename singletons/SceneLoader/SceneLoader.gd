extends Node

var current_scenes = []


func _ready():
	Events.connect("change_scene", self, "goto_scene")


func _get_scene_name(scene_name: String) -> String:
	if scene_name.begins_with("res://"):
		return scene_name

	return "res://scenes/" + scene_name + "/" + scene_name + ".tscn"


func _get_scene_instance(scene_name: String) -> Resource:
	var path = _get_scene_name(scene_name)
	var new_scene = load(path)

	return new_scene.instance()


func show_scene(scene_name: String) -> Resource:
	var new_scene = _get_scene_instance(scene_name)
	$Scenes.add_child(new_scene)
	current_scenes.append(new_scene)

	return new_scene


func goto_scene(scene_name: String):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	call_deferred("_deferred_goto_scene", scene_name)


func _deferred_goto_scene(scene_name: String):
	$AnimationPlayer.connect("animation_finished", self, "_onFadeOutFinished", [scene_name])
	$AnimationPlayer.play("fade-in")


func _onFadeOutFinished(_animation_name: String, scene_name: String):
	$AnimationPlayer.disconnect("animation_finished", self, "_onFadeOutFinished")

	while len(current_scenes):
		var scene = current_scenes.pop_front()
		scene.free()

	show_scene(scene_name)

	$AnimationPlayer.play_backwards("fade-in")
