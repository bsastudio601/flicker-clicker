extends Control

@onready var stats_popup : Panel = $StatsWindow
@onready var stats_button : Button = $Stat_button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stats_popup.hide()
	pass # Replace with function body.

func _on_stat_button_pressed() -> void:
	if not stats_popup.visible:
		stats_popup.show()
	else:
		stats_popup.hide()
		
	pass # Replace with function body.
