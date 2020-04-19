extends KinematicBody2D

export var speed : int = 128
export var maxBounce : int = 1;

var _velocity : Vector2 = Vector2()

var _nbBounce = 0

func _ready():
	pass

func _process(_delta):
	_velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision : KinematicCollision2D = move_and_collide(_velocity*delta)
	if collision:
		if _nbBounce < maxBounce:
			rotation = _velocity.bounce(collision.normal).angle()
			_nbBounce += 1
		else:
			$AnimatedSprite.animation = "explode"
		if collision.collider.has_method("hit"):
			$AnimatedSprite.animation = "explode"
			collision.collider.hit()

func _on_visibility_screen_exited():
	queue_free()


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "explode":
		queue_free()
