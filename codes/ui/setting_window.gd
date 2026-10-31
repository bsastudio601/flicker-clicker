
extends Panel

var bus_index_1: int = AudioServer.get_bus_index("sfx")
var bus_index_2: int = AudioServer.get_bus_index("music")

@onready var sfx_slider: HSlider = $sliders/sfx_slider
@onready var music_slider: HSlider = $sliders/music_slider

func _ready() -> void:
	sfx_slider.value_changed.connect(_on_sfx_slider_changed)
	music_slider.value_changed.connect(_on_music_slider_changed)

func _on_sfx_slider_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index_1, linear_to_db(value))
	$button_click_sfx.play()

func _on_music_slider_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index_2, linear_to_db(value))
