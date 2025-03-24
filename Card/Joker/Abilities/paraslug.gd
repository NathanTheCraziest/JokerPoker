extends JokerAbility

var current_chips: int = 100

func _on_joker_scored(hand_type: CardData.HandType):
	joker_card.shake_card()
	Util.scoring_box.add_chips(current_chips)
	Util.chip_alert.activate(joker_card.global_position, "+%s" % current_chips)
	await get_tree().create_timer(0.2).timeout

func _on_blind_end():
	current_chips -= 20
	Util.chip_alert.activate(joker_card.global_position, "-20")
	if current_chips <= 0:
		joker_card.holder.delete_card(joker_card)

func get_texture_index() -> int:
	return 5

func get_tip_message() -> String:
	return "[center][color=black]Parasitic Slug[/color]
[color=dodger_blue]+%s Chips[/color][color=gray]. Loses [/color][color=dodger_blue]20 Chips[/color][color=gray] at the end of the blind.[/color][/center]
" % current_chips
