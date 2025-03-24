extends Sprite2D

class_name UseButton

var selected_card: CardInstance
var can_use: bool = false

func _ready() -> void:
	Util.use_button = self


func _on_texture_button_button_down() -> void:
	if selected_card != null and CardData.can_interact:
		CardData.can_interact = false
		selected_card.shake_card()
		await get_tree().create_timer(0.2).timeout
		
		if selected_card is ConsumableInstsance:
			
			if Util.sell_button.selected_card == selected_card:
				Util.sell_button.reparent(Util.game_manager)
				Util.sell_button.rotation = 0.0
				rotation = 0.0
			
			if await selected_card.on_use():
				reparent(Util.game_manager)
				selected_card.holder.delete_card(selected_card)
				rotation = 0.0
				
				if selected_card is TarotInstance:
					Util.game_manager.tarots_used += 1
					Util.game_manager.last_used_tarot = selected_card.tarot
				
		CardData.can_interact = true


func set_usable(arg: bool):
	can_use = arg
	modulate = Color.WHITE if can_use else Color(0.5, 0.5, 0.5)
