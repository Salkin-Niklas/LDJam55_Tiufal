extends CharacterBody3D

class_name Enemy

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var attack_timer: Timer = $Attack_Timer
@onready var ability_timer: Timer = $Ability_Timer
@onready var stun_timer: Timer = $Stun_Timer

enum STATES{
	WALKING,
	DEAD,
	ATTACK,
	ABILITY,
	STUNNED,
	DEFAULT
}
var state: STATES = STATES.WALKING

var MAX_HEALTH: float = 100.0
var health: float = 0.0

var  SPEED: float = 5.0
var ATTACK_CD: float = 0.0
var ABILITY_CD: float = 0.0


var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	queue_free()


func _physics_process(delta):

	var cur_pos: Vector3 = global_transform.origin
	var nxt_pos: Vector3 = nav_agent.get_next_path_position()
	velocity = velocity.move_toward((nxt_pos-cur_pos).normalized()*SPEED,0.25)

	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()

func update_target_pos(pos: Vector3):
	nav_agent.target_position = pos

func update_target_vel(vel: Vector3):
	pass

func change_health(amount: float):
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
