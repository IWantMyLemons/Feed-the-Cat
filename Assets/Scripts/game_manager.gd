extends Node

var current_area = 1
var area_path = "res://Assets/Scenes/Area/"

func next_level():
	current_area += 1
	var full_path = area_path + "area_" + str(current_area) + ".tscn"
	#get_tree().change_scene_to_file("res://Assets/Scenes/Area/area_2.tscn")
	get_tree().change_scene_to_file(full_path)
	print("The player have completed the objective!"+str(current_area))
