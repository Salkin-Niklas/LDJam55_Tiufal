extends Area3D

@onready var sprite = $Sprite3D
@onready var shape = $CollisionShape3D
@onready var lifetimer = $Lifetime
const IGNORE_LAYER = (1<<2) | (1<<3)

const SPEED = 30
const DMG = 5
const LIFETIME = 20

var hit = false
var dir = Vector3(0,0,0)

func _ready():
	lifetimer.start(LIFETIME)

func _physics_process(delta):
	if lifetimer.time_left == 0:
		queue_free()
	if hit:
		return
	global_position = global_position + dir*delta*SPEED

func _on_body_entered(body):
	if (body.collision_layer & (1<<4)) and (body.collision_layer & IGNORE_LAYER):
		return
	elif not (body.collision_layer & (1<<4)) and (body.collision_layer & IGNORE_LAYER):
		if body.has_method("change_health"):
			print(DMG)
			body.change_health(-DMG)
	hit = true
	queue_free()
