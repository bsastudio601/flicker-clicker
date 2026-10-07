extends Control
@onready var consumption_num : Label = $Energy_consumption/cps_num
@onready var generation_num : Label = $Energy_Geneation/gps_num
@onready var efficiency_num : Label = $supply_efficiency/sep_num
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_label()
	pass
	
func update_label() ->void:
	consumption_num.text = str(GameData.consumption_per_sec)
	generation_num.text = str(GameData.generation_per_sec)
	
