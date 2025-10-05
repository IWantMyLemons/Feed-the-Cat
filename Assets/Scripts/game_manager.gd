extends Node

var current_area = 1
var area_path = "res://Assets/Scenes/Area/"

var spam = 0

func _on_ready() -> void:
	$Player.collect_spam.connect(add_spam)
	$Player.lose_spam.connect(sub_spam)

func add_spam(_spam: Spam):
	spam += 1
	if spam == 1 :
		var portal = get_tree().get_first_node_in_group("Area_Exits") as AreaExit
		portal.open()

func sub_spam(_spam: Spam):
	spam -= 1
	if spam != 1 :
		var portal = get_tree().get_first_node_in_group("Area_Exits") as AreaExit
		portal.close()

func next_level():
	current_area += 1
	var full_path = area_path + "area_" + str(current_area) + ".tscn"
	# get_tree().change_scene_to_file("res://Assets/Scenes/Area/area_2.tscn")
	get_tree().change_scene_to_file(full_path)
	print("The player have completed the objective!"+str(current_area))
	setup_area()

func setup_area():
	reset_count()
	
func reset_count():
	spam = 0
