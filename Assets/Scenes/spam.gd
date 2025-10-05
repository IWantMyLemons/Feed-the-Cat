class_name Spam
extends RigidBody2D

func pickup(player: Node2D):
	player.jumps += 1
	self.queue_free()
