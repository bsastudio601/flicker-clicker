extends PanelContainer

#Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

#setting vars
var upgrade_name := "Upgraded Filament"
var upgrade_info := "Increases the charge generation to:"
var max_reached_info := "This bulb loses less charge!"


var level := 0
var max_level := 9
var new_var := [2,3,4,5,6.8,10,12,15,18]
var costs := [220,390,700,1200,2200,3900,7000,12000,22000]


func _ready() -> void:
	buy_button.pressed.connect(_on_buy_button_pressed)

	name_label.text = upgrade_name
	info_label.text = upgrade_info

	update_cost()
func _process(_delta: float) -> void:
	update_cost()
	update_upgrade_info()

func _on_buy_button_pressed() -> void:
	buying_item()
	$"../button_click_sfx".play()
	
func update_cost() -> void:
	if level >= max_level:
		cost_label.text = "MAX"
		buy_button.disabled = true
		return

	if costs[level] >= 1000:
		cost_label.text = str(round(costs[level] / 100.0) / 10.0) + "K"
	else:
		cost_label.text = str(costs[level])
	buy_button.disabled = GameData.light < costs[level]

func buying_item() -> void:

	if level >= max_level:
		return

	var cost = costs[level]

	if GameData.light < cost:
		return
	GameData.light -= cost
	
	#here site the actual gamedata var logic
	GameData.main_bulb_charge_generation += new_var[level]

	level += 1
	
	var next_cost: float = costs[level] if level < max_level else -1.0
	var next_level: int = level + 1 if level < max_level else -1

	ProgressionTracker.record_upgrade(
		upgrade_name,
		level,
		cost,
		GameData.light,
		GameData.generation_per_sec_peak,
		GameData.consumption_per_sec,
		next_cost,
		next_level
	)
	
	update_cost()
	
	
func update_upgrade_info() -> void:
	if level >= max_level:
		info_label.text = max_reached_info
		return

	info_label.text = upgrade_info + str(new_var[level])
