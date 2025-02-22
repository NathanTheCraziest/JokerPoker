extends CardHolder

class_name PlayingCardHolder

@onready var draw_pos: Node2D = $DrawPos


func _ready() -> void:
	await get_tree().process_frame
	draw_card(10)

func draw_card(amount: int = 1):
	
	for i in amount:
		if Player.available_cards.size() > 0:
			
			var random: int = randi_range(0, Player.available_cards.size() - 1)
			var card: CardInstance = Player.available_cards[random]
			print("%s of %s" % [Player.available_cards[random].rank, Player.available_cards[random].suit])
			
			card.reparent(holder)
			card.set_sprite_position(draw_pos.position)
			card.set_card_visible(true)
			Player.available_cards.remove_at(random)
			
			organize_cards()


func _on_card_enter_holder(node: Node) -> void:
	if node is CardInstance:
		node.holder = self
