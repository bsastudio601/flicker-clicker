extends Panel

var previous_light: float = 0.0
var timer: float = 0.0

func _ready() -> void:
	previous_light = GameData.light_raw

func _process(delta: float) -> void:
	timer += delta

	if timer >= 1.0:
		var light_gained: float = GameData.light_raw - previous_light

		GameData.generation_per_sec = maxf(light_gained, 0.0) / timer

		GameData.generation_per_sec_peak = maxf(
			GameData.generation_per_sec_peak,
			GameData.generation_per_sec
		)

		previous_light = GameData.light_raw
		timer = 0.0
	
	$Panel/generation.text = "Generation: " + str(snappedf(GameData.generation_per_sec_peak,0.01)) + "/s"
	$Panel/consumption.text = "Consumption: " + str(GameData.consumption_per_sec) + "/s"
	
	var efficiency := 0.0 
	
	if GameData.consumption_per_sec > 0.0:
		GameData.generation_efficiency = (GameData.generation_per_sec_peak / GameData.consumption_per_sec) * 100.0

		$Panel/efficiency.text = "Efficiency: " + "%.2f" % GameData.generation_efficiency + "%"
		
	$Panel/clicks.text = "Total _Clicks: " + str(GameData.clicked)
	
