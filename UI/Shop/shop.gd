extends Node2D

class_name Shop

var shop_hidden: bool = true

var reroll_price: int = 5

@export var show_position: Vector2
@export var hide_position: Vector2
@onready var reroll_holder: RerollHolder = $RerollHolder
@onready var reroll_button: Button = $ShopPanel/Reroll
@onready var reroll_holder_2: RerollHolder = $RerollHolder2


func _ready() -> void:
	Util.shop = self


func set_shop_hidden(arg: bool):
	Util.buy_button.reparent(Util.game_manager)
	reroll_price = 5
	reroll_button.text = "Reroll $%s" % reroll_price
	if !arg:
		reroll_holder.add_random_cards()
		reroll_holder_2.add_random_cards()
	shop_hidden = arg
	
	reroll_holder.check_cards()
	reroll_holder.organize_cards()
	reroll_holder_2.check_cards()
	reroll_holder_2.organize_cards()
	
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", show_position if !shop_hidden else hide_position, 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	
	await tween.finished
	if shop_hidden:
		reroll_holder.clear_cards()
		reroll_holder_2.clear_cards()

func _on_next_button_down() -> void:
	Util.game_manager.advance_blind()
	Util.game_manager.blind_panel.update_blind()
	set_shop_hidden(true)
	Util.game_manager.hand_holder.start_game()
	Util.game_manager.blind_panel.set_panel_visible(true)


func _on_reroll_button_down() -> void:
	
	Util.buy_button.reparent(Util.game_manager)
	
	if Util.game_manager.can_afford(reroll_price):
		Util.game_manager.add_money(-reroll_price)
		reroll_holder.clear_cards()
		reroll_holder.add_random_cards()
		reroll_price += 1
		reroll_button.text = "Reroll $%s" % reroll_price
		
		reroll_holder.check_cards()
		reroll_holder.organize_cards()
