extends TextureProgressBar

@onready var charge_label_white: Label =  $Charge_label_White
@onready var black_mask: Control = $Black_Label_Mask
@onready var charge_label_black: Label = $Black_Label_Mask/Charge_label_Black

func _ready() -> void:
	max_value = GameData.max_charge
	value = GameData.charge

func _process(delta: float) -> void:
	update_charge_bar(delta)
	pass
	
func update_charge_value_visual() -> void: # the text inside the bar control with mask
	var text := str(round(GameData.charge)) + " / " + str(round(GameData.max_charge))

	charge_label_white.text = text
	charge_label_black.text = text

	var charge_percent := GameData.charge / GameData.max_charge

	black_mask.size.x = ( size.x   * charge_percent ) - 14
	
func update_charge_bar(delta: float) -> void: #actual bar fill function
	GameData.charge -= GameData.drain_per_second * delta
	GameData.charge = clamp(GameData.charge, 0.0, GameData.max_charge)

	max_value = GameData.max_charge
	value = GameData.charge

	update_charge_value_visual()
