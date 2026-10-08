extends Node2D

signal hand_clicked

@onready var animation:AnimatedSprite2D = $AnimatedSprite2D
@onready var timer:Timer = $Timer

var clicks := 0

func _ready() -> void:
	visible = false
	animation.play("hand_normal")

func auto_click() -> void:
	timer.wait_time = GameData.clicking_hand_cps

	if GameData.charge >= 0:
		animation.play("hand_clicked")
		await get_tree().create_timer(GameData.clicking_hand_cps * 0.4).timeout
		animation.play("hand_normal")
		hand_clicked.emit()
		
		clicks += 1
		
		if clicks >= GameData.clicking_hand_clicks_before_cooldown:
			clicks = 0
			timer.stop()

			await get_tree().create_timer(GameData.clicking_hand_cooldown).timeout

			if visible:
				timer.start()
	
func activate() -> void:
	visible = true
	timer.wait_time = GameData.clicking_hand_cps
	timer.start()
	
func deactivate() -> void:
	visible = false
	timer.stop()
	
func _on_timer_timeout() -> void:
	auto_click()


	
