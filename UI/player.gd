extends Node


var deck: Array[CardInstance]
var available_cards: Array[CardInstance]

var poker_hands: Dictionary = {
	CardData.HandType.HIGH_CARD: PokerHand.new("High Card", 5.0, 1.0),
	CardData.HandType.PAIR: PokerHand.new("Pair", 10.0, 2.0),
	CardData.HandType.TWO_PAIR: PokerHand.new("Two Pair", 20.0, 2.0),
	CardData.HandType.THREE_OF_A_KIND: PokerHand.new("Three of a Kind", 30.0, 3.0),
	CardData.HandType.STRAIGHT: PokerHand.new("Straight", 30.0, 4.0),
	CardData.HandType.FLUSH: PokerHand.new("Flush", 35.0, 4.0),
	CardData.HandType.FULL_HOUSE: PokerHand.new("Full House", 40.0, 4.0),
	CardData.HandType.FOUR_OF_A_KIND: PokerHand.new("Four of a Kind", 60.0, 7.0),
	CardData.HandType.STRAIGHT_FLUSH: PokerHand.new("Straight Flush",  100.0, 8.0),
	CardData.HandType.ROYAL_FLUSH: PokerHand.new("Royal Flush", 100.0, 8.0),
	CardData.HandType.FIVE_OF_A_KIND: PokerHand.new("Five of a Kind", 120.0, 12.0),
	CardData.HandType.FLUSH_HOUSE: PokerHand.new("Flush House", 140.0, 14.0),
	CardData.HandType.FLUSH_FIVE: PokerHand.new("Flush Five", 160.0, 16.0)
}

func draft_starter():
	for suit in CardData.Suit.values():
		
		for rank in CardData.Rank.values():
			
			deck.append(CardData.create_playing_card(rank, suit))


func refresh_available_cards():
	available_cards = deck.duplicate()


func _ready() -> void:
	draft_starter()
	refresh_available_cards()
