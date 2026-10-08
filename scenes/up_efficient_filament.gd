extends PanelContainer

#Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

#setting vars
var upgrade_name := "Efficient Filament"
var upgrade_info := "Increases the charge generation to: "
var max_reached_info := "Max efficiency reached"


var level := 0
var max_level := 5
var new_var := [2,3,4,5,6]
var costs := [100,500,1000,2500,5000]


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
	update_cost()
	
	#here site the actual gamedata var logic
	
	
	GameData.main_bulb_charge_generation += new_var[level]

	
	
func update_upgrade_info() -> void:
	if level >= max_level:
		info_label.text = max_reached_info
		return

	info_label.text = upgrade_info + str(new_var[level])
