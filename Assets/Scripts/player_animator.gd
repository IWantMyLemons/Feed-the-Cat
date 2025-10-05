extends Node2D

@export var player_controller : PlayerController
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

func _process(_delta):
	#flip tergantung arah yang dia mau kemana
	if player_controller.direction == 1:
		sprite.flip_h = false
	elif player_controller.direction == -1:
		sprite.flip_h = true
		#Animasi gerak dan idle
	if abs(player_controller.velocity.x) > 0.0:
		animation_player.play("Move")
	else:
		animation_player.play("Idle")
		#Animasi lompat
	if player_controller.velocity.y < 0.0:
		animation_player.play("Jump")
	elif player_controller.velocity.y > 0.0:
		animation_player.play("Fall")
		
