extends Node2D

@onready var timer: Timer = $Timer

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
	GameData.light += 1
	$DamageNumberSpawner.spawn_label(GameData.light)
	print("is being called1")
