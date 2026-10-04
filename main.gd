extends Node2D
var clicked := GameData.clicked
var cps := 0
@onready var point_light: PointLight2D = $Bulb/PointLight2D
@onready var charge_bar : TextureProgressBar = $Charge_Bar


func _ready() -> void:


	charge_bar.max_value = GameData.max_charge
	charge_bar.value = GameData.charge
	
func _process(delta: float) -> void:
	charge_bar.value = GameData.charge
	
	GameData.charge += cps * GameData.charge_per_click * delta
	GameData.charge -= GameData.drain_per_second * delta 
	GameData.charge = clamp(GameData.charge, 0.0, GameData.max_charge)
	update_bulb()
	update_light_label()
	print(GameData.charge)
	

func _on_texture_button_pressed() -> void:
	clicked += 1
	add_light()
	
func update_cpm() -> void:
	cps = clicked
	clicked = 0

	$CPM_Lable.text = str(cps)
func update_bulb() -> void:
	
	var brightness := GameData.charge /GameData.max_charge
	point_light.energy = lerp(0.5 , 4.0 , brightness)
	
func _on_cpm_timer_timeout() -> void:
	update_cpm()

func add_light() -> void:
	var multiplier = GameData.base_multiplier
	
	if GameData.charge >= GameData.max_charge:
		multiplier *= GameData.charge_multiplier
		$Charge_Bar/Multiplier_Label.text = str(GameData.charge_multiplier) + "x"
	else:
		$Charge_Bar/Multiplier_Label.text = ""
		
	GameData.light += round(multiplier)
	
func update_light_label()-> void:
	if GameData.light >= 1000:
		$Light_Label.text = str(round(GameData.light / 100.0) / 10.0) + "K"
	else:
		$Light_Label.text = str(GameData.light)
