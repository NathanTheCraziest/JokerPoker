extends Sprite2D

class_name BuyButton

var selected_card: CardInstance

func _ready() -> void:
	Util.buy_button = self


func update_text():
	$Value.text = "$%s" % selected_card.buy_value


func _on_texture_button_button_down() -> void:
	if selected_card != null:
		print("BUY")
		if Util.game_manager.can_afford(selected_card.buy_value):
			
			selected_card.shake_card()
			
			if selected_card.card_type == CardData.Type.JOKER and Util.game_manager.joker_holder.cards.size() < Util.game_manager.joker_holder.container_size:
				
				selected_card.holder.selected.remove_at(selected_card.holder.selected.find(selected_card))
				selected_card.reparent(Util.game_manager.joker_holder.holder)
				selected_card.is_selected = false
				Util.game_manager.joker_holder.check_cards()
				Util.game_manager.joker_holder.organize_cards()
				Util.game_manager.add_money(-selected_card.buy_value)
				
				hide()
				reparent(Util.game_manager)
