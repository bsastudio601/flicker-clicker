extends CanvasLayer
@onready var factory_popup : Panel = $Factory_Popup


func _ready() -> void:
	factory_popup.hide()

func _on_factory_button_pressed() -> void:
	factory_popup.show()

func _on_factory_close_pressed() -> void:
	factory_popup.hide()
