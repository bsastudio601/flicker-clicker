extends PanelContainer

#Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

#setting vars
var upgrade_name := "Fast Charging"
var upgrade_info := "Decreases the charging time"

var charge_per_click_increase := 2
var level := 0
var max_level := 5

var costs := [100,500,1000,1500,2000]


func _ready() -> void:
	buy_button.pressed.connect(_on_buy_button_pressed)

	name_label.text = upgrade_name
	info_label.text = upgrade_info

	update_cost()
	
func _process(_delta: float) -> void:
	update_cost()


func _on_buy_button_pressed() -> void:
	buying_item()


func update_cost() -> void:

	if level >= max_level:
		cost_label.text = "MAX"
		buy_button.disabled = true
		return

	cost_label.text = str(costs[level])
	buy_button.disabled = GameData.light < costs[level]


func buying_item() -> void:

	if level >= max_level:
		return

	var cost = costs[level]

	if GameData.light < cost:
		return

	GameData.light -= cost
	GameData.charge_per_click += charge_per_click_increase
	level += 1

	update_cost()
