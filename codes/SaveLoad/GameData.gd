extends Node

#track var (dont edit)
var clicked := 0
var charge := 0.0

#currency
var light_raw: float = 100

var light: int:
	get:
		return roundi(light_raw)
	set(value):
		light_raw += value - roundi(light_raw)		
var base_multiplier := 1

#charge
var charge_multiplier := 1
var max_charge := 20
var charge_per_click := 1.0
var drain_per_second := 1.0

#balance system
var generation_per_sec := 0.0
var consumption_per_sec := 100.0

var generation_per_sec_peak := 110.0

var generation_efficiency := 0.0

#main buld vars
var main_bulb_light_generation := 1.0
var main_bulb_charge_generation := 1.0

#clicking hand vars
var clicking_hand_cps := 2.0  #its like 1 click per clicking_hand_cps second
var clicking_hand_cooldown := 5.0
var clicking_hand_clicks_before_cooldown := 5.0

#extra light var 
var extra_bulb_light_generation := 1.0
var extra_bulb_charge_consumption := 10.0
var extra_bulb_generation_interval := 1.0

#balance system var
var total_power_generation := 0.0 
var total_charges_generation := 0.0 
var total_power_consumption := 0.0 

var power_generation_per_second := 0.0 
var power_consumption_per_second := 0.0 

var total_light := light

#Upgrade saves
var level_upgraded_capacity := 0
var level_efficient_battery := 0
var level_overcharge_protection := 0
var level_bright_filament := 0
var level_upgraded_filament := 0
var level_clicker_hands := 0
var level_clicker_hand_speed := 0
var level_clicker_hand_cooldown := 0
var level_extra_bulb := 0
var level_extra_bulb_intensity := 0
var level_extra_bulb_efficiency := 0
var level_extra_bulb_effectiveness := 0

var level_ascend :=0

#news saves
var news_progress: Dictionary = {}
