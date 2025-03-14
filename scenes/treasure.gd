extends AnimatedSprite2D

var is_open := false

func open_treasure():
	if not is_open:
		is_open = true
		play("open")
