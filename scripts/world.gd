extends Node2D

export var Bullet : PackedScene
var score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func _on_BulletTimer_timeout():
	$spawningPath/spawnLocation.offset = randi()
	var bullet = Bullet.instance()
	$bulletPool.add_child(bullet)
	var directionAngle = $spawningPath/spawnLocation.rotation + PI/2
	directionAngle += rand_range(-PI/3, PI/3)
	bullet.position = $spawningPath/spawnLocation.position + Vector2(16, 0).rotated(directionAngle) # don't spawn in the wall
	bullet.rotation = directionAngle


func _on_victim_dead():
	$BulletTimer.stop()
	get_tree().set_pause(true)
	$elapsedTime.hide()
	$gameoverLayer.show()

func _on_gameoverButton_pressed():
	queue_free()
