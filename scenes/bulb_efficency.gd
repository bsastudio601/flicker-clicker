extends PanelContainer
#labels
@onready var name_label:Label = $Upgrade_Hbox/Upgrade_Vbox/Upgrade_Name
@onready var info_label:Label = $Upgrade_Hbox/Upgrade_Vbox/Upgrade_Info
@onready var cost_label:Label = $Upgrade_Hbox/VBoxContainer/Cost

#settings variables
var upgrade_name := "Bulb Efficency"
var upgrade_info := "Charge drains slower"
var cost := 100
var battery_increase:= 100

func _ready() -> void:
	$"Upgrade_Hbox/VBoxContainer/Buy Button".pressed.connect(_on_buy_button_pressed)
	name_label.text = upgrade_name
	info_label.text = upgrade_info
	cost_label.text = str(cost)
	
func _on_buy_button_pressed() -> void:
	print("Efficency upgrade bought!")
	
	
