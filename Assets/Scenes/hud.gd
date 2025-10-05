extends Control
class_name HUD
@export var spam_ammount : Label

func update_spam(curr:int, max_spam:int):
	spam_ammount.text = str(curr) + "/" +str(max_spam)
