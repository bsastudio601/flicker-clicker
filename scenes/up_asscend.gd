extends PanelContainer

# Labels
@onready var name_label: Label = $Control/Upgrade_Name
@onready var info_label: Label = $Control/Upgrade_Info
@onready var cost_label: Label = $Control/Cost
@onready var buy_button: Button = $"Control/Buy Button"

# Upgrade settings
var upgrade_name := "Ascend"
var upgrade_info := "You need to reach 99.99% efficiency"

var level := 0
var max_level := 1
var costs := [100000]


func _ready() -> void:
	buy_button.pressed.connect(_on_buy_button_pressed)

	name_label.text = upgrade_name
	info_label.text = upgrade_info

	update_cost()
	update_upgrade_info()


func _process(_delta: float) -> void:
	update_cost()
	update_upgrade_info()


func _on_buy_button_pressed() -> void:
	buying_item()
	$"../button_click_sfx".play()


func update_cost() -> void:
	if level >= max_level:
		cost_label.text = "!!!"
		buy_button.disabled = true
		return

	if GameData.generation_efficiency < 99.99:
		cost_label.text = "100K"
		buy_button.disabled = true
		return

	var cost: int = costs[level]

	if cost >= 1000:
		cost_label.text = str(snappedf(float(cost) / 1000.0, 0.1)) + "K"
	else:
		cost_label.text = str(cost)

	buy_button.disabled = GameData.light < cost


func buying_item() -> void:
	if level >= max_level:
		return

	if GameData.generation_efficiency < 99.99:
		return

	var cost: int = costs[level]

	if GameData.light < cost:
		return

	level += 1
	GameData.light -= cost

	update_cost()
	update_upgrade_info()

	# Cutscene will be added here later.


func update_upgrade_info() -> void:
	if level >= max_level:
		info_label.text = "You have finished your job!"
	else:
		info_label.text = upgrade_info
