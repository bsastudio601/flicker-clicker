extends PanelContainer

@onready var ghost_button : Button = $Control/Button
@onready var headline_label : Label = $Control/headline
@onready var date_label : Label = $Control/date
@onready var details_label : Label = $Control/details


@export var headline: String = "New Headline"
@export var date: String = "10-23-26"
@export_multiline var details : String = "lorem"
@export var consumption_adds : float = 0.0
@export var gps_required : float = 5.0



var expanded := false

func _ready() -> void:
	
	hide()
	
	headline_label.text = headline
	date_label.text = date
	details_label.text = details
	
	custom_minimum_size.y = 32
	ghost_button.custom_minimum_size.y = 32
	details_label.custom_maximum_size.y = 16 

func _on_button_pressed() -> void:
	expanded = not expanded

	if expanded:
		custom_minimum_size.y = 128
		ghost_button.custom_minimum_size.y = 128
		details_label.custom_maximum_size.y = 112
		$button_sound.play()
	else:
		custom_minimum_size.y = 32
		ghost_button.custom_minimum_size.y = 32
		details_label.custom_maximum_size.y = 16 
		$button_sound.play()

func check_gps() -> void:
	if gps_required >= GameData.generation_per_sec:
		show()
		
