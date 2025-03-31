extends Enemy


var target_pos := Vector3(0,0,0)
var target_vel := Vector3(0,0,0)

func _ready():
	MAX_HEALTH = 50
	health = 50
	ATTACK_CD = 2

func _physics_process(delta: float):
	pass

func _process(delta: float):
	if health == 0:
		queue_free()
		return
	attack()

func update_target_pos(pos: Vector3):
	target_pos = pos

func update_target_vel(vel: Vector3):
	target_vel = vel

func ability():
	pass

func attack():
	if attack_timer.time_left == 0.0:
		#var shoot_pos = global_position + Vector3(0,1.5,0)
		#var arrow = preload("res://arrow.tscn").instantiate()
		#get_parent().add_child(arrow,true)
		#arrow.global_position = shoot_pos
		#var distance = (target_pos+target_vel - arrow.global_position).length()
		#arrow.dir = ((Vector3(0,2,0)+target_pos+target_vel*distance/arrow.SPEED)-arrow.global_position).normalized()
		#arrow.global_rotation.z = Vector3(0,0,arrow.dir.z).signed_angle_to(Vector3(0,1,0),Vector3(1,0,0))
		#arrow.global_rotation.y =  Vector3(arrow.dir.x,0,0).signed_angle_to(Vector3(0,0,1),Vector3(0,1,0))
		#arrow.global_rotation.x =  -Vector3(0,arrow.dir.y,0).signed_angle_to(Vector3(1,0,0),Vector3(0,0,1))
		#attack_timer.start(ATTACK_CD)
		
		target_vel.y = 0
		var arrow: Area3D = preload("res://arrow.tscn").instantiate()
		get_parent().add_child(arrow,true)
		var shoot_origin: Vector3 =  global_position + Vector3(0,1.5,0)
		arrow.global_transform.origin = shoot_origin
		var distance: float = (target_pos+target_vel - arrow.global_position).length()
		var shoot_dir: Vector3 = ((Vector3(0,2,0)+target_pos+target_vel*distance/arrow.SPEED)-arrow.global_position).normalized()
		# fuck this rotation shit
		arrow.look_at(shoot_origin + shoot_dir, Vector3.UP)
		arrow.dir = ((Vector3(0,2,0)+target_pos+target_vel*distance/arrow.SPEED)-arrow.global_position).normalized()
		attack_timer.start(ATTACK_CD)
		
