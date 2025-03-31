extends Node3D

@onready var Player_lifebar: Control = $Interface/Healthbar
@onready var Player: Node = $Player

signal change_health(amount)

func _ready():
	# Connect Signals
	Player.connect("health_changed", Player_lifebar.update_health)
	Player.connect("maxhealth_changed", Player_lifebar.update_maxhealth)
	self.connect("change_health", Player.change_health)


func _process(delta):
	get_tree().call_group("enemies","update_target_pos",Player.PlayerBody.global_transform.origin)
	get_tree().call_group("enemies","update_target_vel",Player.PlayerBody.velocity)
	if Input.is_key_pressed(KEY_BACKSPACE):
		change_health.emit(-1)
