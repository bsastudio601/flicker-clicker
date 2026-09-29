extends PanelContainer

signal buy_pressed(upgrade_item)


@onready var buy_button: Button = $HBox/Buy_Button


func _ready() -> void:
	buy_button.pressed.connect(_on_buy_button_pressed)


func _on_buy_button_pressed() -> void:
	buy_pressed.emit(self)
