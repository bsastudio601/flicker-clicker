extends Control

@onready var power_generation :Label = $PowerPerSecondTitle/PowerPerSecond
@onready var power_consumption :Label = $ConsumptionPerSecondTitle/ConsumptionPerSecond

var sample_timer := 0.0

var pre_onesec_power :=  0.0
var pre_onesec_consumption := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pre_onesec_power = GameData.total_power_generation
	pre_onesec_consumption = GameData.total_power_consumption
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sample_timer += delta

	if sample_timer >= 1.0:
		total_calc(sample_timer)
		sample_timer = 0.0

	pass
	
func total_calc(elapsed:float) -> void:
	if elapsed <= 0.0:
		return

	# Measure actual Light generation
	var light_generated := GameData.total_power_generation - pre_onesec_power
	GameData.power_generation_per_second = light_generated / elapsed
	pre_onesec_power = GameData.total_power_generation
	power_generation.text = "%.2f/s" % GameData.power_generation_per_second
	
	var light_consumption:= GameData.total_power_consumption - pre_onesec_consumption 
	GameData.power_consumption_per_second = light_consumption / elapsed
	pre_onesec_consumption = GameData.total_power_consumption
	power_consumption.text = "%.2f/s" % GameData.power_consumption_per_second
	
