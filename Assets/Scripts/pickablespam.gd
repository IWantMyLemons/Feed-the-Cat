extends Area2D

func _on_body_entered(body):
	if body is PlayerController:
		body.spam_ammount += 1
		GameManager.addspam()
		queue_free() 
