extends Control
class_name HUD
@export var spam_ammount : Label

func update_spam(curr:int, max:int):
		spam_ammount.text = str(curr) + "/" +str(max)
