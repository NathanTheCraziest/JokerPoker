extends Node

class_name JokerAbility

var joker_card = null


func _ready() -> void:
	if get_parent() is JokerInstance:
		joker_card = get_parent()


func _on_joker_scored(hand_type: CardData.HandType):
	pass


func _on_card_scored(card: CardInstance):
	pass

func get_texture_index() -> int:
	return 0

func get_tip_message() -> String:
	return "Joker"
