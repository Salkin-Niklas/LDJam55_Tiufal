extends Node

class_name Enemy

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

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_health(amount):
	health += amount
	if health <= 0:
		state = STATES.DEAD
		health = 0
	if health > MAX_HEALTH:
		health = MAX_HEALTH

