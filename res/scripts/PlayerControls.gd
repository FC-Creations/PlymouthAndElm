extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -150.0
const MAX_JUMP_VELOCITY = -220.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false
var is_active = false

@onready var animated_sprite = $AnimatedSprite2D
func _ready():
	animated_sprite.animation = "default"
func _physics_process(delta):
	if not is_active:
		velocity.x = move_toward(velocity.x,0,5)
		animated_sprite.animation = "default"
		handle_animation()
		var is_colliding =  move_and_slide()
		if not is_colliding and not is_on_floor():
			velocity.y += gravity * delta
		
		return
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		
	if Input.is_action_pressed("jump") and not is_on_floor() and is_jumping:
		if velocity.y < MAX_JUMP_VELOCITY+5:
			is_jumping = false
		else:
			velocity.y = move_toward(velocity.y,MAX_JUMP_VELOCITY,400*delta)
			
	if not Input.is_action_pressed("jump"):
		is_jumping = false
	if not is_on_floor() and not is_jumping:
		velocity.y += gravity * delta
		
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction < 0:
		animated_sprite.flip_h = true
	elif direction > 0:
		animated_sprite.flip_h = false

	if direction:
		var desiredSpeed = SPEED
		if Input.is_action_pressed("run"):
			desiredSpeed *= 1.5
		velocity.x = move_toward(velocity.x, direction * desiredSpeed,10)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	handle_animation()
	move_and_slide()

func handle_animation():
	if velocity.x != 0 and is_on_floor():
		animated_sprite.animation = "move"
		animated_sprite.speed_scale = abs(velocity.x*0.01)
	else:
		animated_sprite.animation = "default"
