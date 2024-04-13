extends CharacterBody3D


var PlayerRotation = Vector2(0,0)
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	pass

func _physics_process(delta):
	if global_position.y < -10:
		global_position = Vector3(0,0,0)
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if get_parent().state == get_parent().STATES.DEAD:
		velocity.x = 0
		velocity.z = 0
		move_and_slide()
		return

	# Handle jump.
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# velocity is instant make increasing
	#seitwärts movement langsamer?
	var input_dir = Vector3(0,0,0)
	if Input.is_key_pressed(KEY_W):
		input_dir.z = -1
	if Input.is_key_pressed(KEY_A):
		input_dir.x = -1
	if Input.is_key_pressed(KEY_D):
		input_dir.x = 1
	if Input.is_key_pressed(KEY_S):
		input_dir.z = 1
	var direction = (transform.basis * input_dir.normalized()).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
