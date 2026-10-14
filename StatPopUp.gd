extends Control

@onready var stats_popup : Panel = $StatsWindow
@onready var setting_popup:Panel = $SettingWindow
@onready var stats_button : TextureButton = $Stat_button
@onready var setting_button: TextureButton =  $Setting_button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stats_popup.hide()
	setting_popup.hide()
	
	pass # Replace with function body.

func _on_stat_button_pressed() -> void:
	if stats_popup.visible:
		stats_popup.hide()
	else:
		setting_popup.hide()
		stats_popup.show()



func _on_texture_button_pressed() -> void:
	if setting_popup.visible:
		setting_popup.hide()
	else:
		stats_popup.hide()
		setting_popup.show()
