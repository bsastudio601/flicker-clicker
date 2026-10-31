extends PanelContainer

#Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

#setting vars
var upgrade_name := "Clicking Cooldown"
var upgrade_info := "decreases cooldown to: "
var upgrade_info_2 := "and clicks to cooldown to:  "
var max_reached_info := "WATERCOOLED!"



var level := 0
var max_level := 5
var new_var := [10,8,6.5,5,4,3] #for colldown time
var new_var_2 := [20,40,50,60,70,100] #for clicks before cooldown
var costs := [820,1700,3500,7300,15000,30000]


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
	
	
	GameData.clicking_hand_cooldown = new_var[level]
	GameData.clicking_hand_clicks_before_cooldown = new_var_2[level]

	
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
		info_label.text = max_reached_info
		return

	info_label.text = upgrade_info + str(new_var[level]) + "sec" + upgrade_info_2 +str(new_var_2[level])
var unlocked := false
@onready var dependent_on : PanelContainer = $"../Clicker_Hands_Up"

func hiding_unhiding_dependent() -> void:
	if dependent_on.visible:
		unlocked = true

	if unlocked:
		show()
	else:
		hide()
