extends CharacterBody3D

class_name Enemy

@onready var nav_agent = $NavigationAgent3D

enum STATES{
	WALKING,
	DEAD,
	ATTACK,
	ABILITY,
	STUNNED,
	DEFAULT
}
var state = STATES.WALKING

var MAX_HEALTH = 100
var health = 0

const SPEED = 5.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):

	var cur_pos = global_transform.origin
	var nxt_pos = nav_agent.get_next_path_position()
	velocity = velocity.move_toward((nxt_pos-cur_pos).normalized()*SPEED,0.25)

	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()

func update_target_pos(pos):
	nav_agent.target_position = pos

func update_target_vel(vel):
	pass

func change_health(amount):
	health += amount
	if health <= 0:
		state = STATES.DEAD
		health = 0
	if health > MAX_HEALTH:
		health = MAX_HEALTH

func ability():
	pass

func attack():
	pass
