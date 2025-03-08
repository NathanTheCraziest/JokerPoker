extends Sprite2D

class_name SellButton

var selected_card: CardInstance

func _ready() -> void:
	Util.sell_button = self


func _on_texture_button_button_down() -> void:
	if selected_card != null:
		reparent(Util.game_manager)
		Util.game_manager.add_money(selected_card.sell_value)
		selected_card.holder.delete_card(selected_card)
