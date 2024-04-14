extends Area3D

@onready var sprite = $Sprite3D
@onready var shape = $CollisionShape3D

const SPEED = 20
const DMG = 50

var hit = false
var dir = Vector3(0,0,0)

func _ready():
	pass

func _physics_process(delta):
	if hit:
		return
	global_position = global_position + dir*delta*SPEED

func _on_body_entered(body):
	print(body)
	if body.get_parent().has_method("change_health"):
		print(DMG)
		body.get_parent().change_health(-DMG)
	hit = true
	#shape.disabled = true
	#sprite.visible = false
	queue_free()
