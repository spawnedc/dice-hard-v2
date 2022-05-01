extends Node2D

signal fighter_idle

onready var animatedSprite = $AnimatedSprite
# onready var audioStreamPlayer = $AudioStreamPlayer
onready var start_position = global_position
var is_idle = true
var is_running = false
var is_attacking = false
var is_returning = false
export(int) var attack_x_position = 100
var target_x_position = 0


func _ready():
	target_x_position = start_position.x + attack_x_position
	animatedSprite.connect("animation_finished", self, "_on_animation_finished")


func _process(delta):
	if is_running:
		if global_position.x < target_x_position - 1:
			global_position = global_position.move_toward(
				Vector2(target_x_position, start_position.y), 200 * delta
			)
		else:
			global_position.x = target_x_position
			hit()

	if is_returning:
		if global_position.x > start_position.x + 1:
			global_position = global_position.move_toward(
				Vector2(start_position.x, start_position.y), 200 * delta
			)
		else:
			global_position.x = start_position.x
			idle()


func start_attack():
	is_idle = false
	is_running = true
	is_attacking = false
	is_returning = false
	animatedSprite.play("run")
	z_index = 1


func hit():
	is_running = false
	is_attacking = true
	is_returning = false
	animatedSprite.play("attack")
	# audioStreamPlayer.play()


func idle():
	is_running = false
	is_attacking = false
	is_returning = false
	animatedSprite.flip_h = !animatedSprite.flip_h
	animatedSprite.play("idle")
	z_index = 0
	is_idle = true
	emit_signal("fighter_idle")


func _on_animation_finished():
	if animatedSprite.animation == "attack":
		animatedSprite.flip_h = !animatedSprite.flip_h
		animatedSprite.play("run")
		is_returning = true
