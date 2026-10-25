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
	
	$Panel/generation.text = str(GameData.generation_per_sec_peak)
	
	$Panel/consumption.text = str(GameData.consumption_per_sec)
