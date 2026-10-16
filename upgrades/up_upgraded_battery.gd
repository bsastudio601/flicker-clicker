extends PanelContainer

#Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

#setting vars
var upgrade_name := "Upgraded Battery"
var upgrade_info := ""


var level := 0
var max_level := 5
var drain_decrease_percent:= [5,5,5,5,5,5]
var costs := [380,860,2000,4550,10500,24000]


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
	level += 1
	
	var decrease = GameData.drain_per_second * (drain_decrease_percent[level] / 100.0)
	GameData.drain_per_second = GameData.drain_per_second - decrease

	update_cost()
	
func update_upgrade_info() -> void:
	if level >= max_level:
		info_label.text = "Best battery of the world!"
		return

	info_label.text = "Decreses battery drain by " + str(drain_decrease_percent[level]) + "%"
