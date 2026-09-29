extends CanvasLayer
@onready var factory_popup : Panel = $Factory_Popup


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	factory_popup.hide()



func _on_factory_button_pressed() -> void:
	factory_popup.show()
	pass # Replace with function body.


func _on_factory_close_pressed() -> void:
	factory_popup.hide()
	pass # Replace with function body.
