extends PanelContainer
signal upgrade_unlocked

#Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

#setting vars
var upgrade_name := "Clicking Hand Speed"
var upgrade_info := "Increases the speed generation to: "
var max_reached_info := "Max speed reach reached"


var level := 0
var max_level := 7
var new_var := [0.9,0.8,0.7,0.6,0.5,0.42,0.35,0.3]
var costs := [250,490,950,1850,3600,7050,13500,27000]


func _ready() -> void:
	buy_button.pressed.connect(_on_buy_button_pressed)

	name_label.text = upgrade_name
	info_label.text = upgrade_info

	update_cost()
	
func _process(_delta: float) -> void:
	update_cost()
	update_upgrade_info()
	hiding_unhiding_dependent()

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
	update_cost()
	
	#here site the actual gamedata var logic
	
	
	GameData.clicking_hand_cps = new_var[level]

	
	
func update_upgrade_info() -> void:
	if level >= max_level:
		info_label.text = max_reached_info
		return

	info_label.text = upgrade_info + str(new_var[level])
	
var unlocked := false
@onready var dependent_on : PanelContainer = $"../Clicker_Hands_Up"

func hiding_unhiding_dependent() -> void:
	if dependent_on.visible and not unlocked:
		unlocked = true
		show()
		upgrade_unlocked.emit()

	if not unlocked:
		hide()
