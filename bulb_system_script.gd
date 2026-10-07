extends Node2D

#this script controls the buld visual and click function.

@onready var point_light: PointLight2D = $PointLight2D
@onready var bulb_button: TextureButton = $Bulb_Button

var normal_texture: Texture2D
var pressed_texture: Texture2D

@onready var charge_multipler_label: Label = $"../Labels/Charge_Bar/Multiplier_Label"

func _ready() -> void:
	normal_texture = bulb_button.texture_normal
	pressed_texture = bulb_button.texture_pressed
	
func _process(delta: float) -> void:
	update_bulb_visual() # so that it always updates 
		
func _on_bulb_button_pressed() -> void:
	GameData.charge += 1
	add_light_currency()
	
func update_bulb_visual() -> void:
	var brightness := GameData.charge /GameData.max_charge
	point_light.energy = lerp(0.5 , 4.0 , brightness)
	
func add_light_currency() -> void: #adds currency with the max charge multiplier
	var multiplier = GameData.base_multiplier
	
	if GameData.charge >= GameData.max_charge:
		multiplier *= GameData.charge_multiplier
		charge_multipler_label.text = str(GameData.charge_multiplier) + "x"
	else:
		charge_multipler_label.text = ""
		
	GameData.light += round(multiplier)
		
func press_button_animation() -> void: #Call this func to play the animation automatically
	bulb_button.texture_normal = pressed_texture
	await get_tree().create_timer(0.1).timeout
	bulb_button.texture_normal = normal_texture
	
	

	
