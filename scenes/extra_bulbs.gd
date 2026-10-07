extends Node2D

@onready var timer: Timer = $Timer
@onready var temp_number := 1 
func _ready() -> void:
	visible = false


func auto_click() -> void:
	if GameData.charge >= 5:
		GameData.clicked += 1
		GameData.charge -= 5
		add_light()
	else:
		print("did not work?")


func activate() -> void:
	visible = true
	timer.start()


func deactivate() -> void:
	visible = false
	timer.stop()


func _on_timer_timeout() -> void:
	auto_click()


func add_light() -> void:
	GameData.light += temp_number
	$DamageNumberSpawner.spawn_label(temp_number)
	print("is being called1")
