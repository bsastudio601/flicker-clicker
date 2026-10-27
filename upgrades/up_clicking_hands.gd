extends PanelContainer

#Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"
#hands
@onready var clicker1 := $"../../../../../../AutoClickerHand/Clicker_Hand1"
@onready var clicker2 := $"../../../../../../AutoClickerHand/Clicker_Hand2"
@onready var clicker3 := $"../../../../../../AutoClickerHand/Clicker_Hand3"

#setting vars
var upgrade_name := "Clicking Hands"
var upgrade_info := ""


var level := 0
var max_level := 3

var costs := [170,600,2400]


func _ready() -> void:
	buy_button.pressed.connect(_on_buy_button_pressed)

	name_label.text = upgrade_name
	info_label.text = upgrade_info
	
	hide()

	update_cost()
func _process(_delta: float) -> void:
	update_cost()
	update_upgrade_info()
	hiding_unhiding()

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

	if level == 1:
		clicker1.activate()
	elif level == 2:
		clicker2.activate()
	elif level == 3:
		clicker3.activate()
		
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
		
	update_cost()
	update_upgrade_info()
	
func update_upgrade_info() -> void:
	if level >= max_level:
		info_label.text = "More the hand more the light"
		return

	info_label.text = "Adds A automatic clicking hand" 

var unlocked := false

func hiding_unhiding() -> void:
	if GameData.light >= costs[0]:
		unlocked = true

	if unlocked:
		show()
	
