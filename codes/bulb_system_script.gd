extends Node2D

#this script controls the buld visual and click function.

@onready var point_light: PointLight2D = $PointLight2D
@onready var bulb_button: TextureButton = $Bulb_Button

var normal_texture: Texture2D
var pressed_texture: Texture2D
var main_bulb_generation: float = 1

@onready var charge_multipler_label: Label = $"../Labels/Charge_Bar/Multiplier_Label"



func _ready() -> void:
	normal_texture = bulb_button.texture_normal
	pressed_texture = bulb_button.texture_pressed
	
func _process(delta: float) -> void:
	update_bulb_visual() # so that it always updates 
		
func _on_bulb_button_pressed() -> void:
	add_light_and_charge()
	
func add_light_and_charge() -> void: #adds currency with the max charge multiplier
	var charge_generation : float = GameData.main_bulb_charge_generation
	var light_generation : float = GameData.main_bulb_light_generation

	GameData.charge += charge_generation
	
	var main_light_total_payout = light_generation
	
	if GameData.charge >= GameData.max_charge:
		
		main_light_total_payout = light_generation * GameData.charge_multiplier
		
		charge_multipler_label.text = str(GameData.charge_multiplier) + "x"
	else:
		charge_multipler_label.text = ""
	
	GameData.light += round(main_light_total_payout)
	
	$DamageNodeSpawner	.spawn_label(main_light_total_payout)
		






















func update_bulb_visual() -> void:
	var brightness : float = GameData.charge /GameData.max_charge
	point_light.energy = lerp(0.5 , 4.0 , brightness)
	
func press_button_animation() -> void: #Call this func to play the animation automatically
	bulb_button.texture_normal = pressed_texture
	await get_tree().create_timer(0.1).timeout
	bulb_button.texture_normal = normal_texture
	
func clicking_hand_signals() -> void:
	add_light_and_charge()

func _on_clicker_hand_1_hand_clicked() -> void:
	clicking_hand_signals()
	pass # Replace with function body.

func _on_clicker_hand_2_hand_clicked() -> void:
	clicking_hand_signals()
	pass # Replace with function body.

func _on_clicker_hand_3_hand_clicked() -> void:
	clicking_hand_signals()
	pass # Replace with function body.
