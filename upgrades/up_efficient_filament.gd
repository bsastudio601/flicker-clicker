extends PanelContainer

#Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

#setting vars
var upgrade_name := "Efficient Filament"
var upgrade_info := ""


var level := 0
var max_level := 2
var drain_decrease_percent:= [5,7,10]
var costs := [300,700,1100]


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
	
	var decrease = GameData.drain_per_second * (drain_decrease_percent[level] / 100.0)
	GameData.drain_per_second = GameData.drain_per_second - decrease

	update_cost()
	
func update_upgrade_info() -> void:
	if level >= max_level:
		info_label.text = "Filament Efficency MAX"
		return

	info_label.text = "Decreses battery drain by " + str(drain_decrease_percent[level]) + "%"
