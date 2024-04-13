extends Node

@onready var MainCamera = $Camera_pivot/Camera_FP
@onready var PlayerBody = $CharacterBody_player
@onready var MainCameraPivot = $Camera_pivot

signal health_changed(val)
signal maxhealth_changed(val)

enum STATES{
	WALKING,
	FLYING,
	WALL,
	DEAD,
	STUNNED,
	DEFAULT
}
var state = STATES.WALKING

const MOUSE_SENSE = 0.001

var MAX_HEALTH = 100
var health = 0


func _ready():
	change_camera_fov(110)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	MainCameraPivot.global_transform = PlayerBody.global_transform
	
	health = 100
	health_changed.emit(health)

func _input(event):
	if event is InputEventMouseMotion:
		var MouseEvent = event.relative*MOUSE_SENSE
		rotate_player(MouseEvent)

func rotate_player(Movement: Vector2):
	PlayerBody.PlayerRotation += Movement
	PlayerBody.PlayerRotation.y = clamp(PlayerBody.PlayerRotation.y,-1.5,1.2)
	
	PlayerBody.transform.basis = Basis()
	MainCamera.transform.basis = Basis()
	
	PlayerBody.rotate_object_local(Vector3(0,1,0),-PlayerBody.PlayerRotation.x)
	MainCamera.rotate_object_local(Vector3(1,0,0),-PlayerBody.PlayerRotation.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print($CharacterBody_player.global_transform)
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
	

func change_camera_fov(fov):
	MainCamera.set_perspective(clamp(fov,60,120),0.05,4000)

func change_health(amount):
	health += amount
	if health <= 0:
		state = STATES.DEAD
		health = 0
	if health > MAX_HEALTH:
		health = MAX_HEALTH
	health_changed.emit(health)
