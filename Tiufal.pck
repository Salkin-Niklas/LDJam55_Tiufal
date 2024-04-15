GDPC                �                                                                      #   T   res://.godot/exported/133200997/export-4b67ca7ad9dd19891559c90b437727a8-stairs1.res 0�      �      F��y�utn��ޥ4=�    T   res://.godot/exported/133200997/export-76e0adcbc83681695885bae615f516ae-world.scn   p�      3      ��3$��a�xڵ	l�    \   res://.godot/exported/133200997/export-770254619957f061b8d1ea4c73fa3491-mesh_standard.res   Ќ      �      ��v�_�3�س���j݇    T   res://.godot/exported/133200997/export-a3ddbc996d1057c95d2a1dbbd876b665-arrow.scn    
            d1:�k�F�Uw�et�    `   res://.godot/exported/133200997/export-b5d51d2f53957614225212d987eb1f79-collision_standard.res        L      ��v�k/�@J�e�D    `   res://.godot/exported/133200997/export-fbaf29a2f19d042c5e7b8c7c6bae107b-magic_shot_player.scn   �      �      ?�p����T6�p�    ,   res://.godot/global_script_class_cache.cfg   �      �       �E����OoK����u    P   res://.godot/imported/arrow_up.png-21355ee05dc2f19b655c626f41259777.s3tc.ctex               ���3S���!u�J    L   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.s3tc.ctex   `      �U      SW!|��2���v�5�U    X   res://.godot/imported/magic_shot_player.png-011ae0afde7d9c2494539daf2eb84491.s3tc.ctex  `s      �      M�Y&UC�X�q��z��    T   res://.godot/imported/player_down_0.png-69ebe2852d0fdef6d5fc4f806f38de38.s3tc.ctex  ��      �      -nJP����i(ڇ��}       res://.godot/uid_cache.bin  p�      Q      �l�ɇ���|!C�D��       res://Archer.gd         �      KH"x�E�-��O�U��       res://Arrow.gd  �            �I���D`�����m�       res://Brawler.gd       �       ��X�/������A�       res://EnemyBody.gd  `      ,      �q��5g��1Ǳ���       res://Healthbar.gd  �      �       �%R��.�����}/�       res://Label_FPS.gd   o      m       ˁ~���
�퇕���d       res://Mage.gd   po      �       ��X�/������A�       res://Player.gd p�      �	      nA<��`y�VBmoG�m       res://PlayerBody.gd �      f
      �� ��)s�m�^�j�       res://arrow.tscn.remap  ��      b       ���թ�X�G3�;?�Ѩ       res://arrow_up.png.import          �       �xC@H�3��O�>it    $   res://collision_standard.tres.remap ��      o       +���s��~\����       res://icon.svg  ��      �      C��=U���^Qu��U3       res://icon.svg.import   n      �       �	�{�CPk�q�2-�       res://magic_shot_player.gd  `p      �      փmHҤ�������7t    $   res://magic_shot_player.png.import  �      �       ��I�_���ma7.oZ    $   res://magic_shot_player.tscn.remap  `�      n       �~!�ڭ�7��f)۞�d        res://mesh_standard.tres.remap  ��      j       5c�f�`�F�⇱��=        res://player_down_0.png.import  0�      �       ��(LlẔ#�F�       res://project.binary��            oȉ�H�«O�%KW��       res://stairs1.tres.remap@�      d       A�U��P�Y�$�Q>�6#       res://world.gd   �      h      *�U_�!H��^�#       res://world.tscn.remap  ��      b       �t�׵B�}��6�x        extends Enemy


var target_pos = Vector3(0,0,0)
var target_vel = Vector3(0,0,0)

func _ready():
	MAX_HEALTH = 50
	health = 50
	ATTACK_CD = 2

func _physics_process(delta):
	pass

func _process(delta):
	if health == 0:
		queue_free()
		return
	attack()

func update_target_pos(pos):
	target_pos = pos

func update_target_vel(vel):
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
		var arrow = preload("res://arrow.tscn").instantiate()
		get_parent().add_child(arrow,true)
		var shoot_origin =  global_position + Vector3(0,1.5,0)
		arrow.global_transform.origin = shoot_origin
		var distance = (target_pos+target_vel - arrow.global_position).length()
		var shoot_dir = ((Vector3(0,2,0)+target_pos+target_vel*distance/arrow.SPEED)-arrow.global_position).normalized()
		# fuck this rotation shit
		arrow.look_at(shoot_origin + shoot_dir, Vector3.UP)
		arrow.dir = ((Vector3(0,2,0)+target_pos+target_vel*distance/arrow.SPEED)-arrow.global_position).normalized()
		attack_timer.start(ATTACK_CD)
		
      extends Area3D

@onready var sprite = $Sprite3D
@onready var shape = $CollisionShape3D
@onready var lifetimer = $Lifetime
const IGNORE_LAYER = (1<<2) | (1<<3)

const SPEED = 15
const DMG = 50
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
		if body.get_parent().has_method("change_health"):
			print(DMG)
			body.get_parent().change_health(-DMG)
	hit = true
	queue_free()

   RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    margin    size    script 	   _bundled       Script    res://Arrow.gd ��������
   Texture2D    res://arrow_up.png �o�.x�'      local://BoxShape3D_mvtrd �         local://PackedScene_iyo8n �         BoxShape3D            �?  �>  �>         PackedScene          	         names "         Arrow 
   transform    collision_layer    collision_mask    script    Area3D 	   Sprite3D    texture    CollisionShape3D    shape 	   Lifetime 	   one_shot    Timer    _on_body_entered    body_entered    	   variants          1�;�      �?      �?      ��    1�;�                               M�;�  �@      ���E��              �?                                           node_count             nodes     ,   ��������       ����                                              ����                                 ����   	                     
   ����                   conn_count             conns                                       node_paths              editable_instances              version             RSRC            GST2           �����                        � I p��U5� J8  ���UTp\� 1�)�Ԝ�� �8�8Ԝ�TTTT� )�1p��5� �4����TTT\�     �ⴼ!5�uU�     p4��!\^]U��B� ԜE)}Aii�0  Э-�$)AAAU֖I�$I �Z�A ��U��I    IR�I UUU�         (JUUUU            [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bgdyeqfgigmmo"
path.s3tc="res://.godot/imported/arrow_up.png-21355ee05dc2f19b655c626f41259777.s3tc.ctex"
metadata={
"imported_formats": ["s3tc_bptc"],
"vram_texture": true
}
                extends Enemy


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
  RSRC                    CapsuleShape3D            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    margin    radius    height    script           local://CapsuleShape3D_15w12          CapsuleShape3D            �?        @@      RSRC    extends CharacterBody3D

class_name Enemy

@onready var nav_agent = $NavigationAgent3D
@onready var attack_timer = $Attack_Timer
@onready var ability_timer = $Ability_Timer
@onready var stun_timer = $Stun_Timer

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

var  SPEED = 5.0
var ATTACK_CD = 0
var ABILITY_CD = 0


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	queue_free()


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
    extends Control

@onready var bar = $Healthbar



func _ready():
	bar.value = bar.max_value


func update_health(health):
	bar.value = health

func update_maxhealth(maxhealth):
	bar.max_value = maxhealth
    GST2   �   �     �����                � �               ���)TUUU� I�$I�  &!UUUU� I    &!UUUU�z�       &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�zX      &!UUUU� O9    &!UUUU� I�$O'  &!UUUU        ���)UUU� I�$I�  &!UUUU�!@    F!&!UUU�       �1&!U5	 �       �1g!   �         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1g!p   �       �1&!U\` � �   F!&!UUUT� I�$N�'  &!UUUU� �p   &!UUUU�       �1&!%�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1&!TXp@� X8��G)&!��U�zP     &!UUUU�       �1g!  �         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1g)@�� �x � @  &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �:�1UUU�       WD2UU5�       WD2U  �       WD2k@  �       �:�1UUUT�         �1UUUU�         �1UUUU�       �:�1UUU�       WD2� �       WD2U�  �       WD2UUX��       �:�1UUUT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�         wDUUUU�       WD2T\Pp�         �1UUUU�         �1UUUU�       WD25�         wDUUUU�         wDUUUU�         wDUUUU�       WD2PPPP�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2%%%�         wDUUUU�         wDUUUU�         wDUUUU�       WD2@   �       WD+:U   �       WD+:U   �       WD2   �         wDUUUU�         wDUUUU�         wDUUUU�       WD2PPXX�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2555	�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2\\\`�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       6D2UU��       WD2]�  �       WD2UUX��       m:�1UUU�       WD2�% �       wDD   �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       wDD@   �       WD2WX@ �       �:�1UUUT�       WD2UU%�       WD2u�  �       6D2UUWT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       m:�1UUU�       WD2 �         wDUUUU�         wDUUUU�       WL�:   �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WDm:�   �         wDUUUU�         wDUUUU�       WD2P@� �       �:�1UUUT�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2%	�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2TXp`�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD25�U�       wDD   �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       wDD   @�       WD2P\VU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2@pPT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�       ��xLUUU�       ���TU% �       ���u   �       ���TW`  �       ���TUUW\�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       ���TUU�5�       ���T�	  �       ���}   �       ���TUX� �       ��xLUUUT�         wDUUUU�         wDUUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�       ���T%�       ��IJ �`P�       Y�IJ\UUU�       ��IJ�UU�       ���Sp@���         wDUUUU�         wDUUUU�       ���TU�	�       ���TUWP`�         wDUUUU�         wDUUUU�       ��T	C�       ��IJpVUU�       8�IJ5UUU�       ��IJ �       ���TTXPp�         wDUUUU�         wDUUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�       ���T	�       ��IJX\\X�         BUUUU�         BUUUU�       ��IJ�����         wDUUUU�         wDUUUU�       ���T�       ���T@@@@�         wDUUUU�         wDUUUU�       ��IJBBBB�         BUUUU�         BUUUU�       ��IJ%555�       ���T```p�         wDUUUU�         wDUUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�       ���T%U�       ��IJPp� �       ׽IJUUU\�       ��IJUU��       ��nS�����         wDUUUU�         wDUUUU�       ���T�       ���T@@@@�         wDUUUU�         wDUUUU�       ���SC	5�       ��IJUUVp�       ��)JUUU5�       ��IJ �       ���TPXTW�         wDUUUU�         wDUUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�         wDUUUU�       ���T%UU�       ���T  �U�       ���T `WU�       9uxLTUUU�         wDUUUU�         wDUUUU�       ���T	��       ���T@@pW�         wDUUUU�         wDUUUU�       9mwLUUU�       ���T 	�U�       ���T  �U�       ���T�XUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       ��KB��       ��8uU  �       ���TU   �       ���TU�  �       ���TU_� �         wDUUUU�         wDUUUU�         wDUUUU�       \��LUUU�       ϘTUUU �       ϘTUUU �       ϘTUUU �       ϘTUUU �       |��LUUUT�         wDUUUU�         wDUUUU�         wDUUUU�       ���TU� �       ���TU*  �       ���TU   �       ��8uU  ��       ��KBVTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�       xLwDUUU�       ��xLUUU�       �ƘLUUU�       ��z} �       �LwDUUUT�         wDUUUU�         wDUUUU�       ���T%�       ���T  �\�       ���T  �U�       ���T  �U�       ���T  *5�       ���TXPPP�         wDUUUU�         wDUUUU�       wLwDUUUU�       ����@@@�       �ƘL�UUU�       ��xL�UUU�       xLwDTUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       7D2���         wDUUUU�         wDUUUU�         wDUUUU�       ���T�       ���TUU  �       ���TUU� �       ���TUU� �       ���T �       ���TTTTV�         wDUUUU�         wDUUUU�       ���T��       ���TPp` �       ���TUU� �       ���TUU* �       ���TUU  �       ���T@@@@�         wDUUUU�         wDUUUU�         wDUUUU�       6D2TTVW�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       L:�1UUU�       WD2 �         wDUUUU�         wDUUUU�       ���TUUU�       ���T �UU�       ���T �UU�       ���T  UU�       ���T  UU�       \�xLTWUU�         wDUUUU�         wDUUUU�       �xL�UU�       ���T  UU�       ���T  UU�       ���T �UU�       ���T UU�       ���T`UUU�         wDUUUU�         wDUUUU�       WD2 �@p�       +:�1TUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2%�UU�       WD:  	�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2  �p�       WD2XVUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       D25UUU�       WD2 %U�       WDQ;   �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD1;   `�       WD2 �XU�       �C
2\UUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       RC
25UUU�       WD2 -UU�       WD2  -U�       WD,:   ��       WL�C   -�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WL�C   x�       WD+:   _�       WD2  xU�       WD2 xUU�       RC
2\UUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       
2�1UUU�       �:�1
UUU�       �:�1UUU�       �:�1�UUU�       �:�1�UUU�       
2�1TUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�z 0    &!UUUU�       �1g!  �         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1g) ��@�x  ` 
   &!UUUU� 1�  &!UUUU�       �1&!%�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1&!@pXT�  (��%G)&!��� ɑ�I�$  &!UUUU�   �F!&!UUU�       �1&! 	5U�       �1g)   )�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1g)   h�       �1&! `\U�    
4F!&!TUUU� x�$I�$  &!UUUU        ���)UUUT� ���I�$  &!UUUU�  0 ���G)&!UU]�x    �N  &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�x    �5  &!UUUU�   `��$G)&!UUu�� p�$I�$  &!UUUU        ���)UUU� I��	�RF!TUUU��     �1&!UU-�       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �P    �1&!UUx�� I�$`8�RF!UUU�P   �1&!�5%�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU� �  �1&!V\XP�       �1&!�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �C
2UUU%�       WD2UU� �       +:�1UUUT�       :�1UUU�       WD2UUs �       �C
2UUUX�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�       WD2VT� �       WD2�* �         wDUUUU�       WD2@@@@�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       �:�1UUU�       WD2UU_��       WD2UU�%�       WD2	  �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2`@  �       WD2UUWX�       WD2UU��       �:�1UUUT�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       WD2	�         wDUUUU�       WD�C   �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD�Cp   �         wDUUUU�       WD2\P`@�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       WD25��         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2@P\V�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       1C�1�         wDUUUU�       ��,S�C�       ��IJ� �U�       ���TUWTZ�       ��TUUU�       ���TUUUT�       ���TU���       ��IJ �U�       ��S�����         wDUUUU�       QC�1TTTT�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       1C�1�         wDUUUU�       ��IJbcC�       ��)JUUU�       גTQQXT�       ���T5555�       ���T\\\\�       ϓL��%�       ��)JUUU��       ��IJ�����         wDUUUU�       QC�1TTTT�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       1C�1�         wDUUUU�       ^ߘT5UUU�       ���T�UUU�       �TwDTUUU�       ���T5�UU�       ���T\VUU�       �TwDUUU�       ���TUUU�       ~�T\UUU�         wDUUUU�       QC�1TTTT�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       ��
:���       ���T� UU�       ���T_ %�       xLwDUUUT�       ���TUU�       ���TU� ��       ���TU� ��       ���TUUTT�         wDUUUU�       ���T� �X�       ���T� UU�       Ք
:TTWW�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       ;�1�UU�       WD�:   �       ���T%5�U�       ���TU 
U�       ���T* U�       \�xLTVWU�       ;�xL��U�       ���TT� U�       ���TU �U�       ���TXXVU�       WD�:   @�       �:�1TVUU�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�         �1UUUU�       WD2	%�U�       WD+:   �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD:   p�       WD2`XWU�         �1UUUU�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�         �1UUUU�         �1UUUU�       m:�1UUU�       WD2�UU�       WD2 
UU�       WD2  UU�       WD2  UU�       WD2 �UU�       WD2�WUU�       m:�1TUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1&!PPPP�    �1&!%5��         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�  @ 
 �1&!PX\V� 1�I�$�RF!UUUT�    �
�1&!-UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�     5�1&!�xUU� �&N�$�RF!UUU� 	   �1&!V5�       �1&!U   �       �1&!U   �       �1&!U   �       �1&!U   �       �1&!U   �       �1&!U   � `   �1&!�\p@�       �1&!�         �1UUUU�       WD2U�55�       WD2URp �       WD2U� �       WD2UW\\�         �1UUUU�       �1&!@@@@�       �1&!�       WD2U��       WD25	  �         wDUUUU�         wDUUUU�       WD2\`  �       WD2U[@��       �1&!@@@@�       �1&!�       WD2	�       ]��R��R�       |��LUUU��       |��LUUU�       ]��R�����       WD2@`pp�       �1&!@@@@�       �1&!�       WD2�       [�IJ\R��       �ƘL�U�       �ΘL��VU�       [�IJ5����       WD2pppp�       �1&!@@@@�       �1&!�       ��+B����       ^ߘTXQ���       �ΘL�	sZ�       �ΘL_`ͥ�       ^ߘT%EK_�       ��+Bp___�       �1&!@@@@�       �1&!�       D2UUU�       WD2 �U�       WD2   U�       WD2   U�       WD2 �^U�       �C2TUUU�       �1&!@@@@�  @ ��1&!5V�       �1&!   U�       �1&!   U�       �1&!   U�       �1&!   U�       �1&!   U�       �1&!   U�   ��&�1&!@p\��D     �1F!��       7D�)UUu��       7D�)UU]B�D�@   �1F!_@���       7D�)�%%5�       ��m:�����       ��m:z��
�       7D�)WXX\�       ���1����       ;��J$�,��       ;��J�8��       ���1VVTV�D   �:G!)��U�       7D�) �UU�       7D�) zUU�C    (�:g)hjjU��     �l�1U�-	��     �l�1U_x`��     Y}�1-	�U��      Y}�1x`^U��   �t�1UA�}�       C�:U   �         �BUUUU            [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://b2mdvwsjo67yg"
path.s3tc="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.s3tc.ctex"
metadata={
"imported_formats": ["s3tc_bptc"],
"vram_texture": true
}
    extends Label


func _process(delta: float) -> void:
	set_text("FPS " + str(Engine.get_frames_per_second()))
   extends Enemy


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
  extends Area3D

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
               GST2   <   <     �����                < <                   UUUU            UUUU            UUUU            UUUU            UUUU            UUUU        Ep   � I�$I�  ExUUUU� I�$I�  ExUUUU� A$    ExUUUU        EpP   @         H  UU@             UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU        Ep  UU          ExUUUU I�$y�  ExUUUU� I� 	�   ExUUUU�H      ExUUUU�       Ex$h  @@� I�$$ EpPPTUU           PUUUU         H  TPP@            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU        Ep  � I�$I�  ExUUUU�@$     ExUUUU�2       ExUUUU�         ExUUUU�       Ex$h@   ��H�$  EpPVT`�� L&@0   PUUUU         H  @            H  UUTP            UUUU            UUUU            UUUU            UUUU        Ep  U          ExUUUU� 	� 	   ExUUUU�         ExUUUU�       ExEh  P�       ExEhUUU�       ExEh�       Ex#`@���� ����m#` PUTUU� I�$J�&   PUUUU         H  P@@             UUUU            UUUU            UUUU            UUUU        Ep     � I�	�   ExUUUU�       HpEP�����       HpEP�����       HpEP�����       HpEP�����         E`UUUU�       Ex$h@CC�O��p�x$h PTTTX� Z"5��   PUUUU           PUUUU            UUUU            UUUU            UUUU        Ep  U          ExUUUU�        ExUUUU�       HpEP�����         HPUUUU�         HPUUUU�       H`EP�����       H`EP�����       ExEh��@�$H�EpPXTTX�OX#5���   PUUUU           PUUUU         H  TPP@            UUUU            UUUU        Ep  � I�	�   ExUUUU�       HpEP�����         HPUUUU�         HPUUUU�         HPUUUU�         HPUUUU�         HPUUUU�       HpEP������@    EpPX`��Ɔ9���   PUUUU� LB&d2   PUUUU         H  @@@@            UUUU            UUUU        Ep  �     ExUUUU�       HpEP�����         HPUUUU�         HPUUUU�         HPUUUU�         HPUUUU�         HPUUUU�       H`EP�����         ExUUUU��p�Ԉ	�EpPVVTP� �:�%   PUUUU         H  @@@@            UUUU            UUUU        Ep  � � 	�   ExUUUU�       HpEP����         HPUUUU�         HPUUUU�         HPUUUU�         HPUUUU�         HPUUUU�       HpEP�����         ExUUUU��    �EpP``x� @$@$   PUUUU         H  @@@P            UUUU            UUUU        Ep  � 	�I�$  ExUUUU�         ExUUUU�       HpEP�����       HpEP�����         HPUUUU�         HPUUUU�         HPUUUU�       HpEP�����       ExX�p|�� Ҙ��X PPTWU� @"'rB'   PUUUU         H  PPPP            UUUU            UUUU        Ep  U          ExUUUU�      Ex$h  TT�       Ex$h   �       HpEPꪪ��       HpEP�����       HpEP�����       Hp$P������      EpP ��p��  ذC�#` P�ZVU� �$�R�%   PUUUUO @�$I�$   PUUUU         H  PPPP            UUUU            UUUU            UUUU        Ep  ����� 1ۉ�$$h PUUU�O   !��$h P��UU��   	��EpP�U�       Ex`  �U�       Ex` �VU��    ��EpP �U�� r�6�$h P\UUU� �IC&   PUUUU� H�$I�$   PUUUU         H    @P         H  PUUU            UUUU            UUUU            UUUU         H  U           PUUUUO I�$I�$   PUUUU� �NI�$   PUUUU� ��m�$X PUUU�  �i$�$X PxUUU�   I��$   PUUUU� ���m�$   PUUUU� H�$I�$   PUUUU         H    @P         H  TUUU            UUUU            UUUU            UUUU            UUUU            UUUU         H  UUU         H    U         H     U         H     U         H     U         H     U         H     U         H    @U         H  TUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU        Ep  UU� I��I�Ep  	  � �bb  Ex$p   @k I�$I%Ep  P���         H  UUV\            UUUU            UUUU        Ep  UUU� I��I�Ep    ��     ExEh   `�       ExEh� � �0�pEpPW\PP` I�$I�$ H  X`��            UUUU            UUUU        Ep  %� 1   HpEP�����       HpEP�����       H`EP����������EpPp```� J�&`%   PUUUU         H  UUV�            UUUU� I�	�Ep"@�       HpEP�����         HPUUUU�         HPUUUU��     GpPj�

� �35�)$h PUUWT         H (TTTT            UUUU� ��I��Ep  �       HpEP����       HXGP�����         HPUUUU�       GpP���z� �(Ђ5EpP\^WU         H  ��TT            UUUU        Ep  	���  0 ��EpP  �U��    �GpP�����     <GpP���_�" h�(1EpP`\WU� ؃$O�$ H    @         H  TTWU            UUUU         H  5�UU I�$I�$ H    �� ��I�$P (   U�  `�I�$P (���U� ��$I�$ H             H  p\WU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU            UUUU           UUU� I���Ep  % � g"<��Ep (@��� I�$I�$ H  UWTX� I�$I�Ep  5%%�P     HpEP������    GpPjj�*� L�$x&P  P𠠐 I��I�$Ep  %%��>    �	GpP������    1GpP*�j^� h"'M�$#` ���^            UUU� 	�$I�$ H   �UU� В$I�$H   �UU         8  TUUU� I��Gp  � K�%��Gp \���� 9�I��G`  -���  	�N�$G` ��__� 1  F` U         #8UUUU            [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cyyxm0saetw0t"
path.s3tc="res://.godot/imported/magic_shot_player.png-011ae0afde7d9c2494539daf2eb84491.s3tc.ctex"
metadata={
"imported_formats": ["s3tc_bptc"],
"vram_texture": true
}
       RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    margin    radius    script 	   _bundled       Script    res://magic_shot_player.gd ��������
   Texture2D    res://magic_shot_player.png �G*�BRZ      local://SphereShape3D_0hrb0 �         local://PackedScene_u2rcp �         SphereShape3D          ���>         PackedScene          	         names "         magic_shot    collision_layer    collision_mask    script    Area3D 	   Sprite3D 
   billboard    texture    CollisionShape3D    shape 	   Lifetime 	   one_shot    Timer    _on_body_entered    body_entered    	   variants                                                            node_count             nodes     *   ��������       ����                                         ����                                 ����   	                     
   ����                   conn_count             conns                                       node_paths              editable_instances              version             RSRC          RSRC                    CapsuleMesh            ��������                                                  resource_local_to_scene    resource_name    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    radius    height    radial_segments    rings    script           local://CapsuleMesh_lwol7 f         CapsuleMesh            �?	        @@      RSRC  extends Node

@onready var MainCamera = $Camera_pivot/Camera_FP
@onready var PlayerBody = $PlayerBody
@onready var MainCameraPivot = $Camera_pivot

@onready var magicshot_timer = $MagicShot_Timer
@onready var chain_timer = $Chain_Timer
@onready var stun_timer = $Stun_Timer
@onready var slide_timer = $Slide_Timer

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

const magicshot_cd = 0.2
const chain_cd = 2
const leap_cd = 5


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

func shoot_magic_shot():
	if magicshot_timer.time_left != 0:
		return
	var shot = preload("res://magic_shot_player.tscn").instantiate()
	get_parent().add_child(shot,true)
	var shoot_origin =  PlayerBody.global_position + Vector3(0,2.5,0)
	shot.global_transform.origin = shoot_origin
	shot.dir = -MainCamera.get_global_transform().basis.z
	magicshot_timer.start(magicshot_cd)
 extends CharacterBody3D


var PlayerRotation = Vector2(0,0)
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SPRINT_SPEED = 4.0
const WALLSLIDE_SPEED = 4.0
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

	# Add the gravity.
	if not is_on_floor() and not (is_on_wall() and Input.is_key_pressed(KEY_SHIFT)):
		velocity.y -= gravity * delta
	else:
		var cam_tilt = (-get_parent().MainCamera.get_global_transform().basis.z).y
		velocity.y += cam_tilt*delta*1.2

	if get_parent().state == get_parent().STATES.DEAD:
		velocity.x *= 0.5
		velocity.z *= 0.5
		move_and_slide()
		return

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
		if Input.is_action_just_released("SHIFT") and (is_on_floor() or is_on_wall()):
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
	
	#print(velocity.length())
	move_and_slide()
          GST2           �����                                  C�UUUU�      ��a���� I    ��a����          C�UUUU I�$I�ƅ�UP  �     ��aS ��      ��a���        ��e�UUU � I�	� X�W��յ��    � ����x���     �W�%%� I�$H$W���UUPT I�I�8�p�  U �     Z��` ���     {�1        ����VT@ � ɐ ɐƅ�U�f�� t$@�&�e�U\Z�� !�� �t!@`��� �,XB$|�u!���� �((΅r}�, �dMI�I7�j�U   y         Q�UUUU            [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cs3hftxwr2lkn"
path.s3tc="res://.godot/imported/player_down_0.png-69ebe2852d0fdef6d5fc4f806f38de38.s3tc.ctex"
metadata={
"imported_formats": ["s3tc_bptc"],
"vram_texture": true
}
           RSRC                 
   PrismMesh            ��������                                                  resource_local_to_scene    resource_name    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    left_to_right    size    subdivide_width    subdivide_height    subdivide_depth    script           local://PrismMesh_mqd2i �      
   PrismMesh              	        �@   @  �?      RSRC            extends Node3D

@onready var Player_lifebar = $Interface/Healthbar
@onready var Player = $Player

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
        RSRC                    PackedScene            ��������                                            �      ..    resource_local_to_scene    resource_name    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    radius    height    radial_segments    rings    script    custom_solver_bias    margin 	   vertices 	   polygons    sample_partition_type    geometry_parsed_geometry_type    geometry_source_geometry_mode 
   cell_size    cell_height    agent_height    agent_radius    agent_max_climb    agent_max_slope    region_min_size    region_merge_size    edge_max_length    edge_max_error    vertices_per_polygon    detail_sample_distance    detail_sample_max_error    filter_low_hanging_obstacles    filter_ledge_spans !   filter_walkable_low_height_spans    filter_baking_aabb    filter_baking_aabb_offset    render_priority 
   next_pass    transparency    blend_mode 
   cull_mode    depth_draw_mode    no_depth_test    shading_mode    diffuse_mode    specular_mode    disable_ambient_light    disable_fog    vertex_color_use_as_albedo    vertex_color_is_srgb    albedo_color    albedo_texture    albedo_texture_force_srgb    albedo_texture_msdf 	   metallic    metallic_specular    metallic_texture    metallic_texture_channel 
   roughness    roughness_texture    roughness_texture_channel    emission_enabled 	   emission    emission_energy_multiplier    emission_operator    emission_on_uv2    emission_texture    normal_enabled    normal_scale    normal_texture    rim_enabled    rim 	   rim_tint    rim_texture    clearcoat_enabled 
   clearcoat    clearcoat_roughness    clearcoat_texture    anisotropy_enabled    anisotropy    anisotropy_flowmap    ao_enabled    ao_light_affect    ao_texture 
   ao_on_uv2    ao_texture_channel    heightmap_enabled    heightmap_scale    heightmap_deep_parallax    heightmap_flip_tangent    heightmap_flip_binormal    heightmap_texture    heightmap_flip_texture    subsurf_scatter_enabled    subsurf_scatter_strength    subsurf_scatter_skin_mode    subsurf_scatter_texture &   subsurf_scatter_transmittance_enabled $   subsurf_scatter_transmittance_color &   subsurf_scatter_transmittance_texture $   subsurf_scatter_transmittance_depth $   subsurf_scatter_transmittance_boost    backlight_enabled 
   backlight    backlight_texture    refraction_enabled    refraction_scale    refraction_texture    refraction_texture_channel    detail_enabled    detail_mask    detail_blend_mode    detail_uv_layer    detail_albedo    detail_normal 
   uv1_scale    uv1_offset    uv1_triplanar    uv1_triplanar_sharpness    uv1_world_triplanar 
   uv2_scale    uv2_offset    uv2_triplanar    uv2_triplanar_sharpness    uv2_world_triplanar    texture_filter    texture_repeat    disable_receive_shadows    shadow_to_opacity    billboard_mode    billboard_keep_scale    grow    grow_amount    fixed_size    use_point_size    point_size    use_particle_trails    proximity_fade_enabled    proximity_fade_distance    msdf_pixel_range    msdf_outline_size    distance_fade_mode    distance_fade_min_distance    distance_fade_max_distance    data    backface_collision    size    subdivide_width    subdivide_height    subdivide_depth    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom 	   bg_color    draw_center    skew    border_width_left    border_width_top    border_width_right    border_width_bottom    border_color    border_blend    corner_radius_top_left    corner_radius_top_right    corner_radius_bottom_right    corner_radius_bottom_left    corner_detail    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    shadow_color    shadow_size    shadow_offset    anti_aliasing    anti_aliasing_size 	   _bundled       Script    res://world.gd ��������   Script    res://Player.gd ��������   Script    res://PlayerBody.gd ��������   Script    res://EnemyBody.gd ��������   Shape3D    res://collision_standard.tres �4�����
   Texture2D    res://player_down_0.png u���T   Script    res://Archer.gd ��������   Script    res://Brawler.gd ��������   Script    res://Mage.gd ��������
   PrismMesh    res://stairs1.tres �A(�LL#   Script    res://Healthbar.gd ��������   Script    res://Label_FPS.gd ��������      local://CapsuleMesh_n8lu1 5         local://CapsuleShape3D_s2pbs i         local://NavigationMesh_s5f81 �      !   local://StandardMaterial3D_tyufa       $   local://ConcavePolygonShape3D_246j5 J         local://BoxShape3D_hlsl0 �         local://BoxMesh_iui3h �         local://BoxShape3D_uf1g1 �         local://BoxMesh_2k128 &         local://StyleBoxFlat_sawlw R         local://StyleBoxFlat_ixlpq �         local://PackedScene_oy28r L         CapsuleMesh    	        �?
        @@         CapsuleShape3D    	        �?
        @@         NavigationMesh       #   T   o�0�   ?  �@;�#�   ?  �?;�C�   ?  �?o�4�   ?  �@<F�   ?  �A8x��   ?  �@o�|�   ?  �@w�ǿ   ?  F�<F�   ?  F�o�4�   ?  �@;�C�   ?  �?;�C�   ?  ��o�d�   ?  �@;�C�   ?  ��w���   ?  ��w�ǿ   ?  F�o�|�   ?  �@o�d�   ?  �@;�C�   ?  ��w�ǿ   ?  F�<F�   ?  �A8x��   ?  �A8x��   ?  �@w���   ?  ���p�   ?  ���C>   ?  F�w�ǿ   ?  F��C>   ?  F��p�   ?  ���{�?   ?  ����EB   ?  ����EB   ?  F{�?  @?  ��;��  @  ��;��  @   ?�{�?  @?   ?��EB   ?  �?��EB   ?  ���{�?  @?  ���{�?  @?   ?��EB   ?  ���{�?   ?  ���{�?  @?  ���{�?  @?   ?�{�?   ?  �?��EB   ?  �?;�#�   ?  �?o�0�   ?  �@o�0�   ?   A�{�?   ?  �?�{�?   ?  �?o�0�   ?   A8x��   ?  �A8x��   ?  FB��EB   ?  FB��EB   ?  �?8x��   ?  �A8x��   ?  �A8x��   ?  FB8x��  A  �A8x��  A  �A8x��  A  �Ao�@�  A  �@o�t�  A  �@o�d�   ?  �@o�p�   ?  �@o�t�   ?  �@o�H�   ?   Ao�L�   ?  �@o�d�   ?  �@8x��   ?  �A8x��   ?  �A8x��   ?  �Ao�H�   ?   Ao�d�   ?  �@o�t�   ?  �@8x��   ?  FB8x��   ?  �A8x��   ?  �A8x��   ?  FB8x��   ?  �A8x��   ?  �A<F�   ?  �A<F�   ?  FB      *                                                                                            
   	                	                                                                                                                                                             #   "                  "   !          '   &   $          $   &   %          *   )   (          -   ,   +          /   .   0          0   .   1          3   2   4          4   2   5          5   2   7          5   7   6          :   9   8          <   ;   =          =   ;   >          >   ;   ?          B   A   @          C   E   D          G   F   H          H   F   K          H   K   J          H   J   I          N   M   L          P   O   Q          Q   O   R          R   O   S           @@         StandardMaterial3D    3                  ConcavePolygonShape3D    �   #         �  �?  @?   @  ��  @?   �  ��  @?   �  �?  @�   �  ��  @�   @  ��  @�   �  �?  @?   �  �?  @�   @  ��  @?   �  �?  @�   @  ��  @�   @  ��  @?   �  �?  @�   �  �?  @?   �  ��  @�   �  �?  @?   �  ��  @?   �  ��  @�   �  ��  @?   @  ��  @?   �  ��  @�   @  ��  @?   @  ��  @�   �  ��  @�         BoxShape3D    �        �B   @  �B         BoxMesh    �        �B   @  �B         BoxShape3D    �        �A   A  �@         BoxMesh    �        �A   A  �@         StyleBoxFlat    �      ���>���>���>  �?�         �         �         �         �      ��1?��C?  �?  �?�        @@         StyleBoxFlat    �      ��:?    ���>  �?�         �         �         �      ��1?��C?  �?  �?         PackedScene    �      	         names "   N      world    script    Node3D    Player    Node    Camera_pivot 
   Camera_FP 
   transform 	   Camera3D    PlayerBody    collision_layer    collision_mask    CharacterBody3D    Mesh_player    visible    mesh    MeshInstance3D    CollisionShape3D    shape    MagicShot_Timer 	   one_shot    Timer    Chain_Timer    Leap_Timer    Stun_Timer    Slide_Timer    Enemies 
   EnemyBody    enemies    NavigationAgent3D    debug_enabled 	   Sprite3d    pixel_size 
   billboard    texture 	   Sprite3D    Attack_Timer    Ability_Timer    Archer    Brawler    Mage    WorldEnvironment    Map    NavigationRegion3D    navigation_mesh    Stairs    StaticBody3D    surface_material_override/0    CollisionShape3D2    Ground    static_floor    collision_priority 	   skeleton    Wall    static_wall 
   Interface 
   Healthbar    layout_mode    anchors_preset    anchor_left    anchor_top    anchor_right    anchor_bottom    offset_left    offset_top    offset_right    grow_horizontal    grow_vertical    Control    offset_bottom !   theme_override_styles/background    theme_override_styles/fill    show_percentage    ProgressBar 
   Label_FPS !   theme_override_colors/font_color    Label    DirectionalLight3D    	   variants    ;                           �?              �?              �?       @         �?              �?              �?      �@                        �?              �?              �?      �?                                         �?              �?              �?	��A^N@!��@                             �?              �?              �?    u��?       ��L>                    �?              �?              �?5��A    lxaA                                               �?              �?              �?    ;Qv?          	                           @     �?              �?              �?      ��                  �?              �?              �?=�p�  ��                              )��    Gt�      �?    Gt?    )���C����@�A                              ?     �?     ��      �     �A             
                    �     X�     C     XA      	         
        C     �B       ��#?      �?              �?              �?              �?�ۦAp��A�ty�      node_count    =         nodes     �  ��������       ����                            ����                          ����                     ����                       	   ����         
                                   ����                                      ����            	                    ����      
                    ����      
                    ����      
                    ����      
                    ����      
                     ����                     ����         
                                     ����                                ����      
              #      ����                !      "                    $   ����      
                 %   ����      
                    ����      
                 &   ����         
                                     ����      
                    ����                          #      ����                !      "                    $   ����      
                 %   ����      
                    ����      
                 '   ����                          ����      
                    ����                          #      ����                !      "                    $   ����      
                 %   ����      
                    ����      
                 (   ����             "             ����      
       "             ����                   "       #      ����                !      "          "          $   ����      
       "          %   ����      
       "             ����      
               )   )   ����                   *   ����        *       +   +   ����   ,          +          -   ����        ,       .   .   ����   
                -             ����               /          -          0   ����                   +          1   ����        0       .   2   ����   
            3          1             ����                   1             ����             !   4   "       +          5   ����      #       4       .   6   ����   
            3          5             ����            $       5             ����             %   4   "                  7   ����        8       D   8   ����   9   &   :      ;   '   <   (   =   '   >   (   ?   )   @   *   A   +   B      C   ,      -       9       I   8   ����   9   .   :   /   ;   '   <   '   =   '   >   '   ?   0   @   1   A   2   E   3   B      C      F   4   G   5   H          8       L   J   ����   A   6   E   7   K   8      9               M   M   ����      :             conn_count              conns               node_paths              editable_instances              version             RSRC [remap]

path="res://.godot/exported/133200997/export-a3ddbc996d1057c95d2a1dbbd876b665-arrow.scn"
              [remap]

path="res://.godot/exported/133200997/export-b5d51d2f53957614225212d987eb1f79-collision_standard.res"
 [remap]

path="res://.godot/exported/133200997/export-fbaf29a2f19d042c5e7b8c7c6bae107b-magic_shot_player.scn"
  [remap]

path="res://.godot/exported/133200997/export-770254619957f061b8d1ea4c73fa3491-mesh_standard.res"
      [remap]

path="res://.godot/exported/133200997/export-4b67ca7ad9dd19891559c90b437727a8-stairs1.res"
            [remap]

path="res://.godot/exported/133200997/export-76e0adcbc83681695885bae615f516ae-world.scn"
              list=Array[Dictionary]([{
"base": &"CharacterBody3D",
"class": &"Enemy",
"icon": "",
"language": &"GDScript",
"path": "res://EnemyBody.gd"
}])
 <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
          
   v���`��t   res://arrow.tscn�o�.x�'   res://arrow_up.png�4�����   res://collision_standard.tres��Zn���;   res://icon.svg�G*�BRZ   res://magic_shot_player.png�I:���B   res://magic_shot_player.tscn�x�7�`�   res://mesh_standard.tresu���T   res://player_down_0.png�A(�LL#   res://stairs1.tres/=�̝�Sk   res://world.tscn               ECFG      application/config/name         LDJam55_Tiufal     application/run/main_scene         res://world.tscn   application/config/features$   "         4.2    Forward Plus       application/run/max_fps      �      application/config/icon         res://icon.svg  +   debug/gdscript/warnings/untyped_declaration         #   importer_defaults/animation_library(               animation/fps        pB   input/SHIFT�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         layer_names/3d_physics/layer_1         Environment    layer_names/3d_physics/layer_2         Entities   layer_names/3d_physics/layer_3         Spells_player      layer_names/3d_physics/layer_4         Spells_enemy   layer_names/3d_physics/layer_5          Environment kills spells/   rendering/anti_aliasing/quality/screen_space_aa         '   rendering/anti_aliasing/quality/use_taa                  