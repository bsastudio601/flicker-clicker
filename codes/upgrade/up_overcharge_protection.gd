extends PanelContainer

#Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

#setting vars
var upgrade_name := "Overcharge Prot."
var upgrade_info := ""


var level := 0
var max_level := 4
var new_var := [2,2.5,3,3.5,4]
var costs := [3000,6500,14000,32000,48000] 


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
		
	level += 1
	GameData.light -= cost
	
	GameData.charge_multiplier = new_var[level]
	
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
		info_label.text = "Getting greedy for light"
		return

	info_label.text = "Increases max charge multiplier to " + str(new_var[level]) + "x"
