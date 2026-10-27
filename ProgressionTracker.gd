
extends Node

var session_start: int = 0

var upgrade_events: Array[Dictionary] = []
var news_events: Array[Dictionary] = []
var item_configs: Array[Dictionary] = []
var timeline_events: Array[Dictionary] = []


func _ready() -> void:
	session_start = Time.get_ticks_msec()


func get_elapsed() -> float:
	return (Time.get_ticks_msec() - session_start) / 1000.0


# UNIFIED GAMEPLAY TIMELINE
func record_timeline(event_type: String, item_name: String) -> void:
	timeline_events.append({
		"time": get_elapsed(),
		"event": event_type,
		"name": item_name,
		"light": GameData.light,
		"gps": GameData.generation_per_sec,
		"consumption": GameData.consumption_per_sec
	})


# UPGRADE LOG

func record_upgrade(
	upgrade_name: String,
	level_bought: int,
	cost_paid: float,
	light_remaining: float,
	generation_after: float,
	consumption_after: float,
	next_cost: float,
	next_level: int
) -> void:
	upgrade_events.append({
		"time": get_elapsed(),
		"name": upgrade_name,
		"level_bought": level_bought,
		"cost_paid": cost_paid,
		"light_remaining": light_remaining,
		"generation_after": generation_after,
		"consumption_after": consumption_after,
		"next_cost": next_cost,
		"next_level": next_level
	})

# NEWS LOG
func record_news(
	headline: String,
	gps_required: float,
	gps_at_unlock: float,
	delay: float,
	consumption_added: float,
	consumption_after: float
) -> void:
	news_events.append({
		"time": get_elapsed(),
		"headline": headline,
		"gps_required": gps_required,
		"gps_at_unlock": gps_at_unlock,
		"delay": delay,
		"consumption_added": consumption_added,
		"consumption_after": consumption_after
	})


# ITEM CONFIGURATION LOG
func record_config(
	category: String,
	item_name: String,
	properties: Dictionary
) -> void:
	item_configs.append({
		"category": category,
		"name": item_name,
		"properties": properties.duplicate(true)
	})


# CSV HELPERS
func csv_value(value: Variant) -> String:
	var result := str(value)
	result = result.replace("\"", "\"\"")
	return "\"" + result + "\""


func write_csv(
	path: String,
	headers: PackedStringArray,
	rows: Array[Dictionary]
) -> bool:
	var file := FileAccess.open(path, FileAccess.WRITE)

	if file == null:
		push_error("Could not open CSV: " + path)
		return false

	var header_line := PackedStringArray()

	for header in headers:
		header_line.append(csv_value(header))

	file.store_line(",".join(header_line))

	for row in rows:
		var values := PackedStringArray()

		for header in headers:
			values.append(csv_value(row.get(header, "")))

		file.store_line(",".join(values))

	file.close()
	return true


# EXPORT ALL LOGS
func export_csv() -> void:
	print("EXPORT CSV CALLED")
	var base := "user://"

	# Upgrade history
	write_csv(
		base + "upgrade_log.csv",
		PackedStringArray([
			"time",
			"name",
			"level_bought",
			"cost_paid",
			"light_remaining",
			"generation_after",
			"consumption_after",
			"next_cost",
			"next_level"
		]),
		upgrade_events
	)

	# News history
	write_csv(
		base + "news_log.csv",
		PackedStringArray([
			"time", "headline", "gps_required",
			"gps_at_unlock", "delay",
			"consumption_added", "consumption_after"
		]),
		news_events
	)

	# Unified gameplay timeline
	write_csv(
		base + "gameplay_timeline.csv",
		PackedStringArray([
			"time", "event", "name",
			"light", "gps", "consumption"
		]),
		timeline_events
	)

	# Item configurations
	var config_rows: Array[Dictionary] = []
	var config_headers := PackedStringArray(["category", "name"])

	for item in item_configs:
		var row: Dictionary = {
			"category": item["category"],
			"name": item["name"]
		}

		for property in item["properties"]:
			var key := str(property)
			row[key] = item["properties"][property]

			if not config_headers.has(key):
				config_headers.append(key)

		config_rows.append(row)

	write_csv(
		base + "item_configs.csv",
		config_headers,
		config_rows
	)

	print("Progression logs exported to: ", base)
	print("Timeline events: ", timeline_events.size())
