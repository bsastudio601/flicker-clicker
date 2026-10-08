extends Control

@onready var light_label : Label = $Light_Label


func _ready() -> void:
	update_light_label()




func _process(delta: float) -> void:
	update_light_label()

func update_light_label()-> void:
	if GameData.light >= 1000:
		light_label.text = str(round(GameData.light / 100.0) / 10.0) + "K"
	else:
		light_label.text = str(GameData.light)
