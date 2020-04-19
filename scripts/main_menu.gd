extends Control

export var Level : PackedScene = preload("res://scenes/world.tscn")

func _ready():
	pass

func _on_playButton_pressed():
	var level = Level.instance()
	add_child(level)
	level.connect("tree_exited", self, "_on_level_exited")

func _on_level_exited():
	if get_tree() != null :
		get_tree().set_pause(false)
