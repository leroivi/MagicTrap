extends KinematicBody2D

signal dead

export var speed : int = 32
export var distance_to_origin : int = 64
var _flee_direction : Vector2 = Vector2(0,0)

func _ready():
	pass

func _process(_delta):
	var radius : float = $vision/CollisionShape2D.shape.radius
	var bodies = $vision.get_overlapping_bodies()
	_flee_direction = -position/distance_to_origin
	for body in bodies:
		var flee_one : Vector2 = position-body.position
		if flee_one.length() != 0:
			flee_one = (radius/flee_one.length()) * flee_one.normalized()
		_flee_direction += flee_one

func _physics_process(_delta):
	if _flee_direction.length() > 0:
		# warning-ignore:return_value_discarded
		move_and_slide(speed*_flee_direction.normalized())

func hit():
	emit_signal("dead")
