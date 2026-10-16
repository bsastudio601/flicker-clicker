extends Node2D

@onready var timer: Timer = $Timer
@onready var point_light: PointLight2D = $Sprite2D/PointLight2D
var charge_headroom := 1.5
var extra_bulb_generation_interval := 1

func _ready() -> void:
	visible = false
	timer.wait_time = GameData.extra_bulb_generation_interval

func _process(_delta: float) -> void:
	update_bulb_visual()

	timer.wait_time = GameData.extra_bulb_generation_interval

func auto_click() -> void:
	var charge_consumption := GameData.extra_bulb_charge_consumption

	if GameData.charge >= charge_consumption * charge_headroom:
		GameData.charge -= charge_consumption
		add_light()

	else:
		print("not working")

func activate() -> void: #activates the bulb if called by up item
	visible = true
	timer.wait_time = GameData.extra_bulb_generation_interval
	timer.start()

func deactivate() -> void:
	visible = false
	timer.stop()

func _on_timer_timeout() -> void:
	auto_click()

func add_light() -> void:
	var light_generation := GameData.extra_bulb_light_generation
	GameData.light += light_generation
	GameData.total_power_consumption += 10
	GameData.total_power_generation += light_generation
	$DamageNumberSpawner.spawn_label(light_generation)

func update_bulb_visual() -> void:
	var charge_consumption := GameData.extra_bulb_charge_consumption

	if GameData.charge >= charge_consumption:
		create_tween().tween_property(point_light , "energy" , 3.0 , 1.0)

	else:
		create_tween().tween_property(point_light , "energy" , 0.0 , 1.0)
