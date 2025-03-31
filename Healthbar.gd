extends Control

@onready var bar: ProgressBar = $Healthbar



func _ready():
	bar.value = bar.max_value


func update_health(health: float = 0):
	bar.value = health

func update_maxhealth(maxhealth: float = 0):
	bar.max_value = maxhealth
