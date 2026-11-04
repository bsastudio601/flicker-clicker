extends TextureButton

# Called when the node enters the scene tree for the first time.
	
const END_SCENE := preload("res://scenes/cutscene/just_credit_cutscene.tscn")

@onready var fade_out_canvas : ColorRect = $"../../Transition/ColorRect"

func _on_pressed() -> void:
	$"../SettingWindow/button_click_sfx".play()
	await get_tree().create_timer(0.5).timeout 
	SaveLoad._save()
	activate_ending()
	ProgressionTracker.export_csv()
	
func activate_ending() -> void:

	fade_out_canvas.visible = true
	fade_out_canvas.color = Color(0, 0, 0, 1)      # opaque black
	fade_out_canvas.modulate.a = 0.0               # start invisible
	fade_out_canvas.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fade_out_canvas.set_anchors_preset(Control.PRESET_FULL_RECT)

	var fade_out := create_tween()
	fade_out.tween_property(fade_out_canvas, "modulate:a", 1.0, 2.0)
	await fade_out.finished
	await get_tree().process_frame
	get_tree().change_scene_to_packed(END_SCENE)
