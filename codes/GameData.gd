extends Node

#track var (dont edit)
var clicked := 0
var charge := 0.0

#currency
var light := 99999
var base_multiplier := 1

#charge
var charge_multiplier := 2
var max_charge := 100
var charge_per_click := 3.0
var drain_per_second := 1.0

#balance system
var generation_per_sec := 0
var consumption_per_sec := 100

#main buld vars
var main_bulb_light_generation := 1
var main_bulb_charge_generation := 1

#clicking hand vars
var clicking_hand_cps := 2
var clicking_hand_cooldown := 5.0
var clicking_hand_clicks_before_cooldown := 5.0

#extra light var 
var extra_bulb_light_generation := 1
var extra_bulb_charge_consumption := 10

#balance system var
var total_power_generation := 0.0 
var total_charges_generation := 0.0 
var total_power_consumption := 0.0 

var power_generation_per_second := 0.0 
var power_consumption_per_second := 0.0 
