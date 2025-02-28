extends CharacterBody2D

@export var gravity = 200.0
@export var walk_speed = 200
@export var jump_speed = -300

# Double jump variables
var max_jumps = 2
var jump_count = 0

# Dash variables
var is_dashing = false
var dash_duration = 0.2
var dash_timer = 0.0
var dash_cooldown = 1.0
var dash_cooldown_timer = 0.0
var can_dash = true
var dash_speed_multiplier = 2.5
var normal_speed = walk_speed
var double_tap_threshold = 200
var last_left_press_time = 0
var last_right_press_time = 0

# Crouch variables
var is_crouching = false
var crouch_speed = 100

func _physics_process(delta):
	velocity.y += delta * gravity
	
	# Double jump logic
	if Input.is_action_just_pressed('ui_up'):
		if is_on_floor():
			velocity.y = jump_speed
			jump_count = 1
		else:
			if jump_count < max_jumps:
				velocity.y = jump_speed
				jump_count += 1
	
	if is_on_floor():
		jump_count = 0
	
	# Crouching logic
	if Input.is_action_pressed("ui_down"):
		if not is_crouching:
			is_crouching = true
			walk_speed = crouch_speed
			$Sprite.scale.y = 0.5
	else:
		if is_crouching:
			is_crouching = false
			walk_speed = normal_speed
			$Sprite.scale.y = 1.0
	
	# Dash cooldown
	if not can_dash:
		dash_cooldown_timer -= delta
		if dash_cooldown_timer <= 0:
			can_dash = true
	
	# Handle dash duration
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
	
	# Movement handling
	if not is_dashing:
		if Input.is_action_pressed("ui_left"):
			velocity.x = -walk_speed
		elif Input.is_action_pressed("ui_right"):
			velocity.x = walk_speed
		else:
			velocity.x = 0
	
	move_and_slide()

func _input(event):
	# Double tap detection for dash
	if event.is_action_pressed("ui_left"):
		var current_time = Time.get_ticks_msec()
		if current_time - last_left_press_time < double_tap_threshold:
			start_dash(-1)
		last_left_press_time = current_time
	elif event.is_action_pressed("ui_right"):
		var current_time = Time.get_ticks_msec()
		if current_time - last_right_press_time < double_tap_threshold:
			start_dash(1)
		last_right_press_time = current_time

func start_dash(direction):
	if can_dash:
		is_dashing = true
		dash_timer = dash_duration
		velocity.x = direction * normal_speed * dash_speed_multiplier
		can_dash = false
		dash_cooldown_timer = dash_cooldown

func _ready():
	normal_speed = walk_speed
	
func _process(delta):
	pass
