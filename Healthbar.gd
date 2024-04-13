extends Control

@onready var bar = $Healthbar



func _ready():
	bar.value = bar.max_value


func update_health(health):
	bar.value = health

func update_maxhealth(maxhealth):
	bar.max_value = maxhealth
