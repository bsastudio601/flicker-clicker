extends PanelContainer

# Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

# Setting vars
var upgrade_name := "Upgraded Battery"
var upgrade_info := ""

var max_level := 7
var battery_increase := [45, 65, 90, 125, 170, 230, 300]
var costs := [360, 560, 880, 1400, 2200, 3400, 5400]


func _ready() -> void:
	buy_button.pressed.connect(_on_buy_button_pressed)

	name_label.text = upgrade_name

	# Restore battery capacity from the saved upgrade level
	if GameData.level_upgraded_capacity > 0:
		GameData.max_charge = battery_increase[GameData.level_upgraded_capacity - 1]

	update_cost()
	update_upgrade_info()


func _process(_delta: float) -> void:
	update_cost()


func _on_buy_button_pressed() -> void:
	buying_item()
	$"../button_click_sfx".play()


func update_cost() -> void:
	if GameData.level_upgraded_capacity >= max_level:
		cost_label.text = "MAX"
		buy_button.disabled = true
		return

	var cost = costs[GameData.level_upgraded_capacity]

	if cost >= 1000:
		cost_label.text = str(round(cost / 100.0) / 10.0) + "K"
	else:
		cost_label.text = str(cost)

	buy_button.disabled = GameData.light < cost


func buying_item() -> void:
	if GameData.level_upgraded_capacity >= max_level:
		return

	var cost = costs[GameData.level_upgraded_capacity]

	if GameData.light < cost:
		return

	GameData.light -= cost

	
	GameData.max_charge = battery_increase[GameData.level_upgraded_capacity - 1]
	
	GameData.level_upgraded_capacity += 1
	
	var next_cost: float = costs[GameData.level_upgraded_capacity] if GameData.level_upgraded_capacity < max_level else -1.0
	var next_level: int = GameData.level_upgraded_capacity + 1 if GameData.level_upgraded_capacity < max_level else -1

	ProgressionTracker.record_upgrade(
		upgrade_name,
		GameData.level_upgraded_capacity,
		cost,
		GameData.light,
		GameData.generation_per_sec_peak,
		GameData.consumption_per_sec,
		next_cost,
		next_level
	)

	update_cost()
	update_upgrade_info()


func update_upgrade_info() -> void:
	if GameData.level_upgraded_capacity >= max_level:
		info_label.text = "Battery capacity MAX"
		return

	info_label.text = "Increases battery capacity to " + str(battery_increase[GameData.level_upgraded_capacity])
