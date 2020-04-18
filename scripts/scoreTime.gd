extends Label

var _elapsed : float = 0

func _ready():
	pass

func _process(delta):
	_elapsed += delta
	var elapsed = _elapsed
	var seconds = fmod(elapsed,60)
	elapsed /= 60
	var minutes = fmod(elapsed,60)
	elapsed /= 60
	var hours = elapsed
	set_text("%02d:%02d:%02d" % [hours, minutes, seconds])
