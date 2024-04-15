extends CharacterBody3D


var PlayerRotation = Vector2(0,0)
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SPRINT_SPEED = 4.0
const WALLSLIDE_SPEED = 2.0
var max_speed = 0
var slide_dir = Vector3(0,0,0)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	pass

func _physics_process(delta):
	if global_position.y < -10:
		global_position = Vector3(0,0,0)
		return
	if velocity.length() > 100:
		velocity = Vector3(0,0,0)

	if get_parent().state == get_parent().STATES.DEAD:
		velocity.x *= 0.5
		velocity.z *= 0.5
		move_and_slide()
		return

	# Add the gravity.
	if not is_on_floor() and not (is_on_wall() and Input.is_key_pressed(KEY_SHIFT)):
		velocity.y -= gravity * delta
	else:
		var slide_dir = -get_parent().MainCamera.get_global_transform().basis.z
		velocity.y += slide_dir.y*delta*1
		print(slide_dir.y)

	if Input.is_key_pressed(KEY_SHIFT):
		max_speed = SPEED
		if is_on_wall():
			max_speed += WALLSLIDE_SPEED
		if is_on_floor():
			max_speed += SPRINT_SPEED
		
		if Input.is_action_just_pressed("SHIFT"):
			slide_dir = -get_parent().MainCamera.get_global_transform().basis.z
			slide_dir.y = 0
			slide_dir = slide_dir.normalized()
			velocity = slide_dir*1*velocity.length()*(185-rad_to_deg(slide_dir.angle_to(velocity)))/180
			velocity.y -= 6
			get_parent().slide_timer.start(1)
		
		if Input.is_key_pressed(KEY_W) and (is_on_floor() or is_on_wall()):
			velocity.x = move_toward(velocity.x, slide_dir.x * max_speed, 0.1) # delta anpassen
			velocity.z = move_toward(velocity.z, slide_dir.z * max_speed, 0.1) # delta anpassen
	
	else:
		if Input.is_action_just_released("SHIFT") and is_on_floor():
			if get_parent().slide_timer.time_left == 0:
				var dash_dir =  -get_parent().MainCamera.get_global_transform().basis.z
				velocity = dash_dir*2*velocity.length()*(200-rad_to_deg(dash_dir.angle_to(velocity)))/180
		
		else:
			var input_dir = Vector3(0,0,0)
			if Input.is_key_pressed(KEY_W):
				input_dir.z += -1
			if Input.is_key_pressed(KEY_A):
				input_dir.x += -1
			if Input.is_key_pressed(KEY_D):
				input_dir.x += 1
			if Input.is_key_pressed(KEY_S):
				input_dir.z += 1
			var direction = (transform.basis * input_dir.normalized()).normalized()
			if direction:
				velocity.x = move_toward(velocity.x, direction.x * SPEED, 0.1) # delta anpassen
				velocity.z = move_toward(velocity.z, direction.z * SPEED, 0.1) # delta anpassen
			else:
				velocity.x = move_toward(velocity.x, 0, 0.1)
				velocity.z = move_toward(velocity.z, 0, 0.1)




	# Handle jump.
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y += JUMP_VELOCITY


	#seitwärts movement langsamer?
	
	print(velocity.length())
	move_and_slide()
