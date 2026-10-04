extends Node2D

@onready var animation:AnimatedSprite2D = $AnimatedSprite2D
@onready var timer:Timer = $Timer

func _ready() -> void:
	visible = false #changed to true for editing
	animation.play("hand_normal")

func auto_click() -> void:
	animation.play("hand_clicked")
	GameData.clicked += 1
	add_light()
	await get_tree().create_timer(0.5).timeout
	animation.play("hand_normal")

func activate() -> void:
	visible = true
	timer.start()
	
func deactivate() -> void:
	visible = false
	timer.stop()
	
func _on_timer_timeout() -> void:
	auto_click()
	pass # Replace with function body.

func add_light() -> void:
	var multiplier = GameData.base_multiplier

	if GameData.max_charge > 0 and GameData.charge >= GameData.max_charge:
		multiplier *= GameData.charge_multiplier

	GameData.light += round(multiplier)
