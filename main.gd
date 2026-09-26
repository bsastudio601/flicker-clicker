extends Node2D

var clicked := 0
var cps := 0
var charge := 0.0
var max_charge := 100.0
var charge_per_click := 3.0
var drain_per_second := 5.0
@onready var point_light: PointLight2D = $Bulb/PointLight2D
@onready var charge_bar : TextureProgressBar = $Charge_Bar

func _ready() -> void:
	charge_bar.max_value = max_charge
	charge_bar.value = charge
	
func _process(delta: float) -> void:
	charge_bar.value = charge
	
	charge += cps * charge_per_click * delta
	charge -= drain_per_second * delta 
	charge = clamp(charge, 0.0, max_charge)
	
	
	update_bulb()
func _on_texture_button_pressed() -> void:
	clicked += 1
	
func update_cpm() -> void:
	cps = clicked
	clicked = 0

	$CPM_Lable.text = "CPS: " + str(cps)
func update_bulb() -> void:
	
	var brightness := charge /max_charge
	point_light.energy = lerp(0.5 , 4.0 , brightness)
	
func _on_cpm_timer_timeout() -> void:
	update_cpm()
	
