extends Node2D

@onready var timer: Timer = $Timer


var charge_headroom := 1.5
func _ready() -> void:
	visible = false

func auto_click() -> void:
	var charge_consumption := GameData.extra_bulb_charge_consumption
	
	
	if GameData.charge >= charge_consumption * charge_headroom:
		GameData.charge -= charge_consumption
		add_light()
		
	else:
		print("not working")

func activate() -> void: #activates the bulb if called by up item
	visible = true
	timer.start()

func deactivate() -> void:
	visible = false
	timer.stop()

func _on_timer_timeout() -> void:
	auto_click()

func add_light() -> void:
	var light_generation := GameData.extra_bulb_light_generation
	GameData.light += light_generation
	$DamageNumberSpawner.spawn_label(light_generation)
