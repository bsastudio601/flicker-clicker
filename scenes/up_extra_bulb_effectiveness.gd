extends PanelContainer

#Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

#setting vars
var upgrade_name := "E B Effectiveness"
var upgrade_info := ""


var level := 0
var max_level := 5
var new_var := [0.9,0.7,0.5,0.3,0.2,0.1]
var costs := [2800,5600,11000,22500,45000] 


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
	
	GameData.extra_bulb_generation_interval = new_var[level]
	

	update_cost()
	
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
	
func update_upgrade_info() -> void:
	if level >= max_level:
		info_label.text = "Limit of the smalll bulbs reached!"
		return

	info_label.text = "Decreases the generation time to : " + str(new_var[level]) + "s"
