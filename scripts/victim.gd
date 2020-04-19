extends KinematicBody2D

signal dead

export var speed : int = 32
export var distance_to_origin : int = 64
var _flee_direction : Vector2 = Vector2(0,0)
var _near_bodies : Array = []
var _burning : bool = false

func _ready():
	pass

func _process(_delta):
	var radius : float = $vision/CollisionShape2D.shape.radius
	_flee_direction = -position/distance_to_origin
	for body in _near_bodies:
		var flee_one : Vector2 = position-body.position
		if flee_one.length() != 0:
			flee_one = (radius/flee_one.length()) * flee_one.normalized()
		_flee_direction += flee_one
	$AnimatedSprite.flip_h = false
	if _burning:
		$AnimatedSprite.animation = "burn"
	else:
		if _flee_direction.x == 0 and _flee_direction.y == 0 :
			$AnimatedSprite.animation = "idle"
		elif _flee_direction.x > _flee_direction.y:
			$AnimatedSprite.animation = "run_left"
			if _flee_direction.x > 0:
				$AnimatedSprite.flip_h = true
		else:
			if _flee_direction.y > 0:
				$AnimatedSprite.animation = "run_down"
			else:
				$AnimatedSprite.animation = "run_up"

func _physics_process(_delta):
	_near_bodies = $vision.get_overlapping_bodies()
	if _flee_direction.length() > 0:
		# warning-ignore:return_value_discarded
		move_and_slide(speed*_flee_direction.normalized())

func hit():
	$AnimatedSprite.animation = "burn"
	_burning = true
	emit_signal("dead")
