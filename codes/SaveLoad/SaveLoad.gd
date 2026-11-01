extends Node

const SAVE_PATH = "user://savefile.json"


func _save() -> void:
	var contents_to_save: Dictionary = {
		# Tracking
		"clicked": GameData.clicked,
		"charge": GameData.charge,

		# Currency
		"light_raw": GameData.light_raw,
		"base_multiplier": GameData.base_multiplier,

		# Charge
		"charge_multiplier": GameData.charge_multiplier,
		"max_charge": GameData.max_charge,
		"charge_per_click": GameData.charge_per_click,
		"drain_per_second": GameData.drain_per_second,

		# Balance
		"generation_per_sec": GameData.generation_per_sec,
		"consumption_per_sec": GameData.consumption_per_sec,
		"generation_per_sec_peak": GameData.generation_per_sec_peak,
		"generation_efficiency": GameData.generation_efficiency,

		# Main bulb
		"main_bulb_light_generation": GameData.main_bulb_light_generation,
		"main_bulb_charge_generation": GameData.main_bulb_charge_generation,

		# Clicking hands
		"clicking_hand_cps": GameData.clicking_hand_cps,
		"clicking_hand_cooldown": GameData.clicking_hand_cooldown,
		"clicking_hand_clicks_before_cooldown": GameData.clicking_hand_clicks_before_cooldown,

		# Extra bulbs
		"extra_bulb_light_generation": GameData.extra_bulb_light_generation,
		"extra_bulb_charge_consumption": GameData.extra_bulb_charge_consumption,
		"extra_bulb_generation_interval": GameData.extra_bulb_generation_interval,

		# Power statistics
		"total_power_generation": GameData.total_power_generation,
		"total_charges_generation": GameData.total_charges_generation,
		"total_power_consumption": GameData.total_power_consumption,
		"power_generation_per_second": GameData.power_generation_per_second,
		"power_consumption_per_second": GameData.power_consumption_per_second,
		"total_light": GameData.total_light,

		# Upgrade levels
		"level_upgraded_capacity": GameData.level_upgraded_capacity,
		"level_efficient_battery": GameData.level_efficient_battery,
		"level_overcharge_protection": GameData.level_overcharge_protection,
		"level_bright_filament": GameData.level_bright_filament,
		"level_upgraded_filament": GameData.level_upgraded_filament,
		"level_clicker_hands": GameData.level_clicker_hands,
		"level_clicker_hand_speed": GameData.level_clicker_hand_speed,
		"level_clicker_hand_cooldown": GameData.level_clicker_hand_cooldown,
		"level_extra_bulb": GameData.level_extra_bulb,
		"level_extra_bulb_intensity": GameData.level_extra_bulb_intensity,
		"level_extra_bulb_efficiency": GameData.level_extra_bulb_efficiency,
		"level_extra_bulb_effectiveness": GameData.level_extra_bulb_effectiveness,
		"level_ascend": GameData.level_ascend,
		
		#NEWS ITEM
		"news_progress": GameData.news_progress
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	if file == null:
		push_error("Failed to open save file: " + str(FileAccess.get_open_error()))
		return

	file.store_var(contents_to_save)
	file.close()


func _load() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found. Starting a new game.")
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)

	if file == null:
		push_error("Failed to open save file: " + str(FileAccess.get_open_error()))
		return

	var data = file.get_var()
	file.close()

	if not data is Dictionary:
		push_error("Invalid save file.")
		return

	# Tracking
	GameData.clicked = data.get("clicked", 0)
	GameData.charge = data.get("charge", 0.0)

	# Currency
	GameData.light_raw = data.get("light_raw", 250000.0)
	GameData.base_multiplier = data.get("base_multiplier", 1)

	# Charge
	GameData.charge_multiplier = data.get("charge_multiplier", 1)
	GameData.max_charge = data.get("max_charge", 20)
	GameData.charge_per_click = data.get("charge_per_click", 1.0)
	GameData.drain_per_second = data.get("drain_per_second", 1.0)

	# Balance
	GameData.generation_per_sec = data.get("generation_per_sec", 0.0)
	GameData.consumption_per_sec = data.get("consumption_per_sec", 100.0)
	GameData.generation_per_sec_peak = data.get("generation_per_sec_peak", 110.0)
	GameData.generation_efficiency = data.get("generation_efficiency", 0.0)

	# Main bulb
	GameData.main_bulb_light_generation = data.get("main_bulb_light_generation", 1.0)
	GameData.main_bulb_charge_generation = data.get("main_bulb_charge_generation", 1.0)

	# Clicking hands
	GameData.clicking_hand_cps = data.get("clicking_hand_cps", 2.0)
	GameData.clicking_hand_cooldown = data.get("clicking_hand_cooldown", 5.0)
	GameData.clicking_hand_clicks_before_cooldown = data.get("clicking_hand_clicks_before_cooldown", 5.0)

	# Extra bulbs
	GameData.extra_bulb_light_generation = data.get("extra_bulb_light_generation", 1.0)
	GameData.extra_bulb_charge_consumption = data.get("extra_bulb_charge_consumption", 10.0)
	GameData.extra_bulb_generation_interval = data.get("extra_bulb_generation_interval", 1.0)

	# Power statistics
	GameData.total_power_generation = data.get("total_power_generation", 0.0)
	GameData.total_charges_generation = data.get("total_charges_generation", 0.0)
	GameData.total_power_consumption = data.get("total_power_consumption", 0.0)
	GameData.power_generation_per_second = data.get("power_generation_per_second", 0.0)
	GameData.power_consumption_per_second = data.get("power_consumption_per_second", 0.0)
	GameData.total_light = data.get("total_light", GameData.light)

	# Upgrade levels
	GameData.level_upgraded_capacity = data.get("level_upgraded_capacity", 0)
	GameData.level_efficient_battery = data.get("level_efficient_battery", 0)
	GameData.level_overcharge_protection = data.get("level_overcharge_protection", 0)
	GameData.level_bright_filament = data.get("level_bright_filament", 0)
	GameData.level_upgraded_filament = data.get("level_upgraded_filament", 0)
	GameData.level_clicker_hands = data.get("level_clicker_hands", 0)
	GameData.level_clicker_hand_speed = data.get("level_clicker_hand_speed", 0)
	GameData.level_clicker_hand_cooldown = data.get("level_clicker_hand_cooldown", 0)
	GameData.level_extra_bulb = data.get("level_extra_bulb", 0)
	GameData.level_extra_bulb_intensity = data.get("level_extra_bulb_intensity", 0)
	GameData.level_extra_bulb_efficiency = data.get("level_extra_bulb_efficiency", 0)
	GameData.level_extra_bulb_effectiveness = data.get("level_extra_bulb_effectiveness", 0)
	GameData.level_ascend = data.get("level_ascend", 0)
	
	# NEWS SAVE
	GameData.news_progress = data.get("news_progress", {})

	print("Game loaded successfully!")
