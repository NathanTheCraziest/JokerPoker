extends JokerAbility


func _on_card_scored(card: CardInstance):
	if card.suit == CardData.Suit.SPADE or card.enhancement == CardData.Enhancement.WILD and card.enhancement != CardData.Enhancement.STONE:
		await get_tree().create_timer(0.2).timeout
		joker_card.shake_card()
		Util.scoring_box.add_mult(4.0)
		Util.mult_alert.activate(joker_card.global_position, "+4")

func get_texture_index() -> int:
	return 2

func get_tip_message() -> String:
	return "[center][color=black]Azure Joker[/color]
[color=red]+4 Mult[/color][color=gray] for each Spade card scored[/color][/center]
"
