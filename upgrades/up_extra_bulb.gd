extends PanelContainer

#Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"
#han
@onready var bulb1 = $"../../../../../../ExtraAutoBulb/extra_bulbs"
@onready var bulb2 = $"../../../../../../ExtraAutoBulb/extra_bulbs2"

#setting vars
var upgrade_name := "Extra Bulb"
var upgrade_info := ""


var level := 0
var max_level := 2

var costs := [1500,3100]


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

	level += 1

	if level == 1:
		bulb1.activate()
	elif level == 2:
		bulb2.activate()


	update_cost()
	update_upgrade_info()
	
func update_upgrade_info() -> void:
	if level >= max_level:
		info_label.text = "Max number of bulbs reached"
		return

	info_label.text = "adds smaller bulb that generates light with charge" 
