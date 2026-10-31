extends CanvasLayer

@onready var factory_popup: Panel = $Factory_Popup
@onready var factory_button: TextureButton = $"../Factory_Button"
@onready var factory_button_close: TextureButton = $Factory_Popup/Factory_Button_close

@onready var news_popup: Panel = $News_Popup
@onready var news_button: TextureButton = $"../news_button"
@onready var news_button_close: TextureButton = $News_Popup/new_button_close

@onready var stats_popup: Panel = $Stats_Popup
@onready var stats_button: TextureButton = $"../Stats_button"
@onready var stats_button_close: TextureButton = $Stats_Popup/Label/Stats_button_close

@onready var news_notification_dot: Sprite2D = $"../news_button/Sprite2D"
@onready var new_upgrade_unlocked: Sprite2D = $"../Factory_Button/Sprite2D"

var unread_news := 0
var unseen_upgrade := 0


func _ready() -> void:
	factory_popup.hide()
	factory_button_close.hide()

	news_popup.hide()
	news_button_close.hide()

	stats_popup.hide()
	stats_button_close.hide()

	news_notification_dot.hide()
	new_upgrade_unlocked.hide()


func _on_factory_button_pressed() -> void:
	factory_popup.show()
	factory_button_close.show()
	factory_button.hide()

	$Factory_Popup/Panel/Item_List/Item_Vbox/button_click_sfx.play()

	# Clear existing factory notifications.
	unseen_upgrade = 0
	new_upgrade_unlocked.hide()


func _on_factory_button_close_pressed() -> void:
	factory_popup.hide()
	factory_button_close.hide()
	factory_button.show()

	$Factory_Popup/Panel/Item_List/Item_Vbox/button_click_sfx.play()

	# Do not show the dot when closing.
	new_upgrade_unlocked.hide()


func _on_news_button_pressed() -> void:
	news_popup.show()
	news_button_close.show()
	news_button.hide()

	$Factory_Popup/Panel/Item_List/Item_Vbox/button_click_sfx.play()

	unread_news = 0
	news_notification_dot.hide()


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


func _on_news_item_1_new_news() -> void:
	unread_news += 1
	news_notification_dot.show()
	$notification_sfx.play()


func show_factory_notification() -> void:
	# Count the unlock, but only show the dot if the factory is closed.
	unseen_upgrade += 1

	if not factory_popup.visible:
		new_upgrade_unlocked.show()

	$notification_sfx.play()


func _on_clicker_hands_up_upgrade_unlocked() -> void:
	show_factory_notification()


func _on_extra_bulb_up_upgrade_unlocked() -> void:
	show_factory_notification()
