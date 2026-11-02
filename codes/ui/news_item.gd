extends PanelContainer

signal new_news

@onready var ghost_button: Button = $Control/Button
@onready var headline_label: Label = $Control/headline
@onready var date_label: Label = $Control/date
@onready var details_label: Label = $Control/details

@export var headline: String = "New Headline"
@export var date: String = "10-23-26"
@export_multiline var details: String = "lorem"

@export var consumption_adds: float = 0.0
@export var gps_required: float = 5.0
@export var applied_delay: float = 0.0

@export var collapsed_texture: Texture2D
@export var expanded_texture: Texture2D

@export var news_id: String = ""

var applied: bool = false
var expanded: bool = false
var shown: bool = false
var countdown_started: bool = false
var time_remaining: float = 0.0


func _ready() -> void:
	hide()

	headline_label.text = headline
	date_label.text = date
	details_label.text = details

	custom_minimum_size.y = 32
	ghost_button.custom_minimum_size.y = 32
	details_label.custom_maximum_size.y = 16

	change_background(collapsed_texture)

	var progress: Dictionary = GameData.news_progress.get(news_id, {})

	shown = progress.get("shown", false)
	applied = progress.get("applied", false)
	time_remaining = progress.get("time_remaining", applied_delay)

	if shown:
		show()

		if applied:
			details_label.text = details + "\n\nConsumption increased by +" \
				+ str(consumption_adds) + "/sec"


func _process(_delta: float) -> void:
	check_gps()


func _on_button_pressed() -> void:
	expanded = not expanded

	if expanded:
		custom_minimum_size.y = 128
		ghost_button.custom_minimum_size.y = 128
		details_label.custom_maximum_size.y = 112
		change_background(expanded_texture)
	else:
		custom_minimum_size.y = 32
		ghost_button.custom_minimum_size.y = 32
		details_label.custom_maximum_size.y = 16
		change_background(collapsed_texture)

	$button_sound.play()


func check_gps() -> void:
	if news_id == "" or shown or countdown_started:
		return

	if GameData.generation_per_sec_peak < gps_required:
		return

	countdown_started = true

	var remaining_time: float = time_remaining

	while remaining_time > 0.0:
		var timer := get_tree().create_timer(1.0)
		await timer.timeout

		if not is_inside_tree():
			return

		remaining_time -= 1.0
		time_remaining = remaining_time

		GameData.news_progress[news_id] = {
			"shown": false,
			"applied": applied,
			"time_remaining": time_remaining
		}



	ProgressionTracker.record_news(
		headline,
		gps_required,
		GameData.generation_per_sec_peak,
		applied_delay,
		consumption_adds,
		GameData.consumption_per_sec
	)

	shown = true
	show()
	new_news.emit()

	if not applied:
		GameData.consumption_per_sec += consumption_adds
		applied = true

		details_label.text = details + "\n\nConsumption increased by +" \
			+ str(consumption_adds) + "/sec"

	GameData.news_progress[news_id] = {
		"shown": true,
		"applied": applied,
		"time_remaining": 0.0
	}

	SaveLoad._save()


func change_background(texture: Texture2D) -> void:
	if texture == null:
		return

	var style := StyleBoxTexture.new()
	style.texture = texture

	add_theme_stylebox_override("panel", style)
