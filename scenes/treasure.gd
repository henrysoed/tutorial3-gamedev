extends Area2D

var is_open := false
@onready var animplayer = $AnimatedSprite2D
@onready var entered_sfx = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		animplayer.play("open")
		entered_sfx.play()

func _on_body_exited(body: Node2D) -> void:
		if body is CharacterBody2D:
			animplayer.play("close")
