extends Node2D

signal hand_clicked

@onready var animation:AnimatedSprite2D = $AnimatedSprite2D
@onready var timer:Timer = $Timer

@export var click_delay := 0.0 



func _ready() -> void:
	
	visible = false #changed to true for editing
	animation.play("hand_normal")

func auto_click() -> void:
	if GameData.charge >= 0:
		animation.play("hand_clicked")
		
		

		GameData.clicked += 1
		add_light()

		await get_tree().create_timer(0.5).timeout
		animation.play("hand_normal")
		hand_clicked.emit()
		

func activate() -> void:
	visible = true
	await  get_tree().create_timer(click_delay).timeout
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

	
