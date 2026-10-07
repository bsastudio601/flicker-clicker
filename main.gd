extends Node2D

var cps := 0




	


	
func update_light_label()-> void:
	if GameData.light >= 1000:
		$Light_Label.text = str(round(GameData.light / 100.0) / 10.0) + "K"
	else:
		$Light_Label.text = str(GameData.light)
