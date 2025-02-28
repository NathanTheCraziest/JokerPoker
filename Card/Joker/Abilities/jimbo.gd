extends JokerAbility


func _on_joker_scored(hand_type: CardData.HandType):
	joker_card.shake_card()
	Util.scoring_box.add_mult(4.0)
	Util.mult_alert.activate(joker_card.global_position, "+4")
	await get_tree().create_timer(0.2).timeout
