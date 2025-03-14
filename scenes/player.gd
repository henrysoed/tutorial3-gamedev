extends CharacterBody2D

@export var SPEED := 200
@export var JUMP_SPEED := -400
@export var GRAVITY := 1200
@export var INTERACT_DISTANCE := 50.0

@onready var animplayer = $AnimatedSprite2D
@onready var jump_sfx = $AudioStreamPlayer2D
var nearby_treasure: AnimatedSprite2D = null

func _get_input():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_SPEED
		if jump_sfx:
			jump_sfx.play()

	var direction := Input.get_axis("ui_left", "ui_right")
	var animation = "idle"
	if direction:
		animation = "walk right"
		velocity.x = direction * SPEED
		animplayer.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if animplayer.animation != animation:
		animplayer.play(animation)
	
	move_and_slide()

func _physics_process(delta: float) -> void:
	velocity.y += delta * GRAVITY
	_get_input()
	move_and_slide()

func _process(delta: float) -> void:
	if nearby_treasure and Input.is_action_just_pressed("ui_interact"):
		nearby_treasure.open_treasure()

func _on_area_2d_body_entered(body):
	if body.is_in_group("treasure"):
		nearby_treasure = body

func _on_area_2d_body_exited(body):
	if body == nearby_treasure:
		nearby_treasure = null
