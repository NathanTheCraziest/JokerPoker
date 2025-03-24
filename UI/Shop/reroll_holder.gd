extends CardHolder

class_name RerollHolder

@export var max_new_cards: int = 3
@export var offer_jokers: bool = true

func add_random_cards():
	for i in max_new_cards:
		var new_card: CardInstance
		
		if randf() > 0.3 and offer_jokers:
			new_card = Jokers.create_joker(Jokers.abilities.keys().pick_random())
		else:
			if randf() > 0.5:
				new_card = Util.create_tarot(CardData.Tarot.values().pick_random())
			else:
				new_card = Util.create_planet(CardData.Planet.values().pick_random())
		
		new_card.set_sprite_position(new_card.global_position)
		holder.add_child(new_card)
		
	await get_tree().process_frame
	check_cards()
	organize_cards()


func clear_cards():
	var temp_clear: Array[CardInstance]
	check_cards()
	organize_cards()
	temp_clear = cards.duplicate()
	for card in temp_clear:
		delete_card(card)
	
