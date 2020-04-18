extends Control

export var Level : PackedScene = preload("res://scenes/world.tscn")

func _ready():
	pass

func _on_playButton_pressed():
	var level = Level.instance()
	add_child(level)
	#get_tree().change_scene_to(Level)
	level.connect("tree_exited", self, "_on_level_exited")

func _on_level_exited():
	if get_tree() :
		get_tree().set_pause(false)
