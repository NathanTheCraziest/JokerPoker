extends CardHolder

class_name JokerHolder

@onready var hand_checker: HandChecker = $"../Hand/HandChecker"
var sell_value: int = 1

signal _jokers_done_scoring


func _on_card_enter_holder(node: Node) -> void:
	if node is JokerInstance:
		node.holder = self


func score_jokers():
	
	for card in cards:
		if card is JokerInstance:
			await card.ability._on_joker_scored(hand_checker.current_hand)
	
	_jokers_done_scoring.emit()
