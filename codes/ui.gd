extends CanvasLayer
@onready var factory_popup : Panel = $Factory_Popup


func _ready() -> void:
	factory_popup.hide()

func _on_factory_button_pressed() -> void:
	factory_popup.show()
	$Factory_Popup/Panel/Item_List/Item_Vbox/button_click_sfx.play()

func _on_factory_close_pressed() -> void:
	factory_popup.hide()
	$Factory_Popup/Panel/Item_List/Item_Vbox/button_click_sfx.play()
