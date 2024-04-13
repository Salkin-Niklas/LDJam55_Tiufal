extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D

const SPEED = 5.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):

	var cur_pos = global_transform.origin
	var nxt_pos = nav_agent.get_next_path_position()
	velocity = velocity.move_toward((nxt_pos-cur_pos).normalized()*SPEED,0.25)

	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()

func update_target_pos(target_pos):
	print(target_pos)
	nav_agent.target_position = target_pos
