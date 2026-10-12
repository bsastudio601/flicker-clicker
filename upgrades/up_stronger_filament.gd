extends PanelContainer

#Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

#setting vars
var upgrade_name := "Stronger Filament"
var upgrade_info := ""


var level := 0
var max_level := 10
var light_generation_per_click := [2,3,4,5,6,8,10,12,15,18]
var costs := [30,60,120,240,480,960,1900,3850,7700,15500]


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
	GameData.main_bulb_light_generation = light_generation_per_click[level]
	level += 1

	update_cost()
	
func update_upgrade_info() -> void:
	if level >= max_level:
		info_label.text = "Battery capacity MAX"
		return

	info_label.text = "Increases the light generation to " + str(light_generation_per_click[level])
