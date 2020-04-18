extends Node2D

export var wallLengthMax : int = 64

var _drawing : bool = false
var _origin : Vector2 = Vector2(0,0)
var _end : Vector2 = Vector2(0,0)

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		var position = event.position - get_viewport_rect().size/2
		if event is InputEventMouseButton:
			if event.pressed:
				_drawing = true
				_origin = position
				_end = position
				$shield.default_color.a = 0.5
			else:
				_drawing = false
				$shield.default_color.a = 1.0
				var wall = _end-_origin
				$shield/body/collision.shape.set_extents( Vector2(wall.length()/2, $shield.width/2) )
				$shield/body/collision.position = _origin + wall/2
				$shield/body/collision.rotation = wall.angle()
		elif event is InputEventMouseMotion:
			if _drawing:
				var drawnWall : Vector2 = position-_origin
				if drawnWall.length() > wallLengthMax:
					drawnWall = drawnWall.normalized()*wallLengthMax
				_end = _origin + drawnWall
		$shield/body/collision.disabled = _drawing
		var wallPoints : PoolVector2Array = $shield.get_points()
		if _origin == _end:
			wallPoints.resize(0)
			$shield/body/collision.disabled = true
		else:
			wallPoints.resize(2)
			wallPoints.set(0, _origin)
			wallPoints.set(1, _end)
		$shield.set_points(wallPoints)
