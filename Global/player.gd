extends Node


var deck: Array[CardInstance]
var available_cards: Array[CardInstance]


func draft_starter():
	for suit in CardData.Suit.values():
		
		for rank in CardData.Rank.values():
			
			deck.append(CardData.create_playing_card(rank, suit))


func refresh_available_cards():
	available_cards = deck


func _ready() -> void:
	draft_starter()
	refresh_available_cards()
