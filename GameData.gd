extends Node

#track var (dont edit)
var clicked := 0
var charge := 0.0

#currency
var light := 6000
var base_multiplier := 1

#charge
var charge_multiplier := 2
var max_charge := 100
var charge_per_click := 3.0
var drain_per_second := 1.0

#balance system
var generation_per_sec := 0
var consumption_per_sec := 100
