extends Control

export var Level : PackedScene = preload("res://scenes/world.tscn")

func _ready():
	pass

func _on_playButton_pressed():
	var level = Level.instance()
	add_child(level)
	level.connect("tree_exiting", self, "_on_level_exited")

func _on_level_exited():
	get_tree().set_pause(false)


func _on_exitButton_pressed():
	get_tree().quit()
