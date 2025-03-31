extends Node

@onready var MainCamera: Camera3D = $Camera_pivot/Camera_FP
@onready var PlayerBody: CharacterBody3D = $PlayerBody
@onready var MainCameraPivot: Node3D = $Camera_pivot

@onready var magicshot_timer: Timer = $MagicShot_Timer
@onready var chain_timer: Timer = $Chain_Timer
@onready var stun_timer: Timer = $Stun_Timer
@onready var slide_timer: Timer = $Slide_Timer

signal health_changed(val: float)
signal maxhealth_changed(val: float)

enum STATES{
	WALKING,
	FLYING,
	WALL,
	DEAD,
	STUNNED,
	DEFAULT
}
var state: STATES = STATES.WALKING

const MOUSE_SENSE: float = 0.001

var MAX_HEALTH: float = 100.0
var health: float = 0.0

const magicshot_cd: float = 0.2
const chain_cd: float = 2.0
const leap_cd: float = 5.0


func _ready():
	change_camera_fov(110)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	MainCameraPivot.global_transform = PlayerBody.global_transform
	
	health = 100
	health_changed.emit(health)

func _input(event):
	if event is InputEventMouseMotion:
		var MouseEvent: Vector2 = event.relative*MOUSE_SENSE
		rotate_player(MouseEvent)

func rotate_player(Movement: Vector2):
	PlayerBody.PlayerRotation += Movement
	PlayerBody.PlayerRotation.y = clamp(PlayerBody.PlayerRotation.y,-1.5,1.2)
	
	PlayerBody.transform.basis = Basis()
	MainCamera.transform.basis = Basis()
	
	PlayerBody.rotate_object_local(Vector3(0,1,0),-PlayerBody.PlayerRotation.x)
	MainCamera.rotate_object_local(Vector3(1,0,0),-PlayerBody.PlayerRotation.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	MainCameraPivot.global_transform = PlayerBody.global_transform
	if Input.is_key_pressed(KEY_F1):
		change_camera_fov(90)
		print(MainCamera.fov)
	if Input.is_key_pressed(KEY_F2):
		change_camera_fov(MainCamera.fov-1)
		print(MainCamera.fov)
	if Input.is_key_pressed(KEY_F3):
		change_camera_fov(MainCamera.fov+1)
		print(MainCamera.fov)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		shoot_magic_shot()


func change_camera_fov(fov: float):
	MainCamera.set_perspective(clamp(fov,60,120),0.05,4000)

func change_health(amount: float):
	health += amount
	if health <= 0:
		state = STATES.DEAD
		health = 0
	if health > MAX_HEALTH:
		health = MAX_HEALTH
	health_changed.emit(health)

func shoot_magic_shot():
	if magicshot_timer.time_left != 0:
		return
	var shot: Area3D = preload("res://magic_shot_player.tscn").instantiate()
	get_parent().add_child(shot,true)
	var shoot_origin: Vector3 =  PlayerBody.global_position + Vector3(0,2.5,0)
	shot.global_transform.origin = shoot_origin
	shot.dir = -MainCamera.get_global_transform().basis.z
	magicshot_timer.start(magicshot_cd)
