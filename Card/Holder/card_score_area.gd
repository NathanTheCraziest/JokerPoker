extends CardHolder

class_name PlayHolder

signal on_finished_scoring

var can_interact: bool = false
@onready var exit_pos: Node2D = $ExitPos

func score_cards(cards: Array[CardInstance]):
	
	for card in cards:
		card.holder = self
		card.reparent(holder)
		check_cards()
		organize_cards()
		await get_tree().create_timer(0.1).timeout
	
	
	
	var played_cards = holder.get_children()
	
	for card in played_cards:
		card.shake_card()
		await get_tree().create_timer(0.1).timeout
	
	played_cards.reverse()
	
	await get_tree().create_timer(0.5).timeout
	
	for card in played_cards:
		
		if card is CardInstance:
			
			card.position = exit_pos.position
			await get_tree().create_timer(0.1).timeout
			card.set_card_visible(false)
			card.reparent(Player)
	
	cards.clear()
	
	on_finished_scoring.emit()
