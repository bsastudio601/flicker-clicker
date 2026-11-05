extends Node2D
@onready var layer0 : Sprite2D = $layer0
@onready var layer1 : Sprite2D = $layer1
@onready var layer3_light : PointLight2D = $layer1/layer3_light
@onready var fade : ColorRect = $CanvasLayer/ColorRect

@onready var credit_text : Control = $ui/credit_text



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade.visible = true
	fade.color = Color(0, 0, 0, 1)          # opaque black
	fade.modulate.a = 1.0                   # fully covering at the start
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fade.set_anchors_preset(Control.PRESET_FULL_RECT)

	await play_cutscene()
	
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func play_cutscene() -> void:
	
	$AudioStreamPlayer.play()
	var fade_in := create_tween()
	fade_in.set_parallel(true)
	fade_in.tween_property(fade,"modulate:a",0.0,2.0)
	fade_in.tween_property(layer3_light,"energy",6.0,3.0)
	
	await fade_in.finished
	await get_tree().create_timer(1.0).timeout
	
	var exit := create_tween()
	
	exit.set_parallel(true)
	exit.tween_property(layer1,"position:y",layer1.position.y - 210,10.0)

	
	
	exit.tween_property(credit_text,"position:y",credit_text.position.y - 284,10)

	
	await exit.finished
	
func back_to_game() -> void:

	fade.visible = true
	fade.color = Color(0, 0, 0, 1)     # opaque black
	fade.modulate.a = 0.0              # start invisible

	var fade_out := create_tween()
	fade_out.tween_property(fade, "modulate:a", 1.0, 2.0)

	await fade_out.finished
	
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	
func _on_button_pressed() -> void:
	$AudioStreamPlayer.stop()
	back_to_game()
	pass # Replace with function body.
