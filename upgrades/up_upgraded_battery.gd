extends PanelContainer

# Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

# Setting vars
var upgrade_name := "Efficient Battery"
var upgrade_info := ""

var max_level := 5
var drain_decrease_percent := [5, 5, 5, 5, 5]
var costs := [380, 860, 2000, 4550, 10500]


func _ready() -> void:
	buy_button.pressed.connect(_on_buy_button_pressed)

	name_label.text = upgrade_name
	update_cost()
	update_upgrade_info()



func _process(_delta: float) -> void:
	update_cost()


func _on_buy_button_pressed() -> void:
	buying_item()
	$"../button_click_sfx".play()


func update_cost() -> void:
	if GameData.level_efficient_battery >= max_level:
		cost_label.text = "MAX"
		buy_button.disabled = true
		return

	var current_cost = costs[GameData.level_efficient_battery]

	if current_cost >= 1000:
		cost_label.text = str(round(current_cost / 100.0) / 10.0) + "K"
	else:
		cost_label.text = str(current_cost)

	buy_button.disabled = GameData.light < current_cost


func buying_item() -> void:
	if GameData.level_efficient_battery >= max_level:
		return

	var cost = costs[GameData.level_efficient_battery]

	if GameData.light < cost:
		return

	GameData.light -= cost
	GameData.level_efficient_battery += 1

	var decrease = GameData.drain_per_second * (drain_decrease_percent[GameData.level_efficient_battery - 1] / 100.0)
	GameData.drain_per_second -= decrease
	
	GameData.level_efficient_battery += 1

	var next_cost: float = costs[GameData.level_efficient_battery] if GameData.level_efficient_battery < max_level else -1.0
	var next_level: int = GameData.level_efficient_battery + 1 if GameData.level_efficient_battery < max_level else -1

	ProgressionTracker.record_upgrade(
		upgrade_name,
		GameData.level_efficient_battery,
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
	if GameData.level_efficient_battery >= max_level:
		info_label.text = "Best battery of the world!"
		return

	info_label.text = "Decreases battery drain by " + str(drain_decrease_percent[GameData.level_efficient_battery]) + "%"
