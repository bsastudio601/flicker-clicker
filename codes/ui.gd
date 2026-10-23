extends CanvasLayer
@onready var factory_popup : Panel = $Factory_Popup
@onready var factory_button : TextureButton = $"../Factory_Button"
@onready var factory_button_close : TextureButton = $Factory_Popup/Factory_Button_close

@onready var news_popup : Panel = $News_Popup
@onready var news_button : TextureButton = $"../news_button"
@onready var news_button_close : TextureButton = $News_Popup/new_button_close

@onready var stats_popup : Panel = $Stats_Popup
@onready var stats_button : TextureButton = $"../Stats_button"
@onready var stats_button_close : TextureButton = $Stats_Popup/Label/Stats_button_close

func _ready() -> void:
	factory_popup.hide()
	factory_button_close.hide()
	
	news_popup.hide()
	news_button_close.hide()
	
	stats_popup.hide()
	stats_button_close.hide()
	
func _on_factory_button_pressed() -> void:
		factory_popup.show()
		factory_button_close.show()
		factory_button.hide()
		$Factory_Popup/Panel/Item_List/Item_Vbox/button_click_sfx.play()

func _on_factory_button_close_pressed() -> void:
		factory_popup.hide()
		factory_button_close.hide()
		factory_button.show()
		$Factory_Popup/Panel/Item_List/Item_Vbox/button_click_sfx.play()
	
		
func _on_news_button_pressed() -> void:
	news_popup.show()
	news_button_close.show()
	news_button.hide()
	$Factory_Popup/Panel/Item_List/Item_Vbox/button_click_sfx.play()
	
func _on_new_button_close_pressed() -> void:
	news_popup.hide()
	news_button_close.hide()
	news_button.show()
	$Factory_Popup/Panel/Item_List/Item_Vbox/button_click_sfx.play()


func _on_stats_button_pressed() -> void:
	stats_popup.show()
	stats_button_close.show()
	stats_button.hide()
	$Factory_Popup/Panel/Item_List/Item_Vbox/button_click_sfx.play()

func _on_stats_button_close_pressed() -> void:
	stats_popup.hide()
	stats_button_close.hide()
	stats_button.show()
	$Factory_Popup/Panel/Item_List/Item_Vbox/button_click_sfx.play()
 
