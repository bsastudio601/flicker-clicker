extends PanelContainer

#Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

#setting vars
var upgrade_name := "Overcharge Prot."
var upgrade_info := ""


var max_level := 5
var new_var := [2,2.5,3,3.5,4]
var costs := [3000,6500,14000,32000,48000] 


func _ready() -> void:
	buy_button.pressed.connect(_on_buy_button_pressed)

	name_label.text = upgrade_name
	info_label.text = upgrade_info

	update_cost()
	load_save_data()
func _process(_delta: float) -> void:
	update_cost()
	update_upgrade_info()

func _on_buy_button_pressed() -> void:
	buying_item()
	$"../button_click_sfx".play()
	
func update_cost() -> void:
	if GameData.level_overcharge_protection >= max_level:
		cost_label.text = "MAX"
		buy_button.disabled = true
		return
	
	if costs[GameData.level_overcharge_protection] >= 1000:
		cost_label.text = str(round(costs[GameData.level_overcharge_protection] / 100.0) / 10.0) + "K"
	else:
		cost_label.text = str(costs[GameData.level_overcharge_protection])
	buy_button.disabled = GameData.light < costs[GameData.level_overcharge_protection]

func buying_item() -> void:

	if GameData.level_overcharge_protection >= max_level:
		return

	var cost = costs[GameData.level_overcharge_protection]

	if GameData.light < cost:
		return
		

	GameData.light -= cost
	
	GameData.charge_multiplier = new_var[GameData.level_overcharge_protection]
		
	GameData.level_overcharge_protection += 1
		
	var next_cost: float = costs[GameData.level_overcharge_protection] if GameData.level_overcharge_protection < max_level else -1.0
	var next_level: int = GameData.level_overcharge_protection + 1 if GameData.level_overcharge_protection < max_level else -1

	ProgressionTracker.record_upgrade(
		upgrade_name,
		GameData.level_overcharge_protection,
		cost,
		GameData.light,
		GameData.generation_per_sec_peak,
		GameData.consumption_per_sec,
		next_cost,
		next_level
	)

	update_cost()
	
func update_upgrade_info() -> void:
	if GameData.level_overcharge_protection >= max_level:
		info_label.text = "Getting greedy for light"
		return

	info_label.text = "Increases max charge multiplier to " + str(new_var[GameData.level_overcharge_protection]) + "x"

func load_save_data() -> void:
	await get_tree().create_timer(0.5).timeout

	buying_item()
