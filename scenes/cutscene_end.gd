extends Node2D
@onready var layer0 : Sprite2D = $layer0
@onready var layer1 : Sprite2D = $layer1
@onready var layer3_light : PointLight2D = $layer1/layer3_light
@onready var fade : ColorRect = $CanvasLayer/ColorRect

@onready var exit_ui : Control =  $ui/ui_element
@onready var credit_text : Control = $ui/credit_text

@onready var start_again_button: Button = $ui/ui_element/start_again
@onready var exit_button : Button = $ui/ui_element/exit_button



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade.visible = true
	fade.color = Color(0, 0, 0, 1)          # opaque black
	fade.modulate.a = 1.0                   # fully covering at the start
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fade.set_anchors_preset(Control.PRESET_FULL_RECT)

	await play_cutscene()
	
func play_cutscene() -> void:
	var fade_in := create_tween()
	fade_in.set_parallel(true)
	fade_in.tween_property(fade,"modulate:a",0.0,2.0)
	fade_in.tween_property(layer3_light,"energy",6.0,3.0)
	
	await fade_in.finished
	await get_tree().create_timer(1.0).timeout
	
	var exit := create_tween()
	
	exit.set_parallel(true)
	exit.tween_property(layer1,"position:y",layer1.position.y - 210,10.0)

	
	
	exit.tween_property(credit_text,"position:y",credit_text.position.y - 570,20)

	
	await exit.finished
	
	var exit_ui_tween := create_tween()
	exit_ui_tween.tween_property(exit_ui, "position:y",exit_ui.position.y - 170,5)
	
	


func _on_start_again_pressed() -> void:
	start_again()
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	pass # Replace with function body.
	


func start_again() -> void:
	start_again_button.disabled = true
	exit_button.disabled = true

	fade.visible = true
	fade.color = Color(0, 0, 0, 1)     # opaque black
	fade.modulate.a = 0.0              # start invisible
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fade.set_anchors_preset(Control.PRESET_FULL_RECT)

	var fade_out := create_tween()
	fade_out.tween_property(fade, "modulate:a", 1.0, 2.0)
	await fade_out.finished
	await get_tree().process_frame

	get_tree().change_scene_to_file("res://scenes/main.tscn")

	
	
	
