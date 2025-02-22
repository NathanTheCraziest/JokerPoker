extends Node

class_name HandChecker


var holder: CardHolder = null
var current_hand: CardData.HandType

func _ready() -> void:
	if get_parent() is CardHolder:
		holder = get_parent()
		holder.on_hand_changed.connect(on_hand_changed)


func on_hand_changed():
	
	var is_flush: bool = false
	var is_straight: bool = false
	var has_pair: bool = false
	var has_two_pair: bool = false
	var has_three_of_a_kind: bool = false
	var has_four_of_a_kind: bool = false
	var has_five_of_a_kind: bool = false
	var is_royal: bool = false
	
	current_hand = CardData.HandType.HIGH_CARD
	
	# High Card
	if holder.selected.size() >= 1:
		current_hand == CardData.HandType.HIGH_CARD
	
	# Common
	var ranks: Array[CardData.Rank]
	for card in holder.selected:
		if ranks.find(card.rank) == -1:
			ranks.append(card.rank)
	
	# Multiple Kinds
	var all_ranks: Array[CardData.Rank]
	for card in holder.selected:
		all_ranks.append(card.rank)
	
	var no_of_pairs: int = -1
	for rank in all_ranks:
		
		var count: int = 0
		
		for i in all_ranks:
			if rank == i:
				count += 1
		
		if count == 2:
			has_pair = true
			no_of_pairs += 1
		if count == 3:
			has_three_of_a_kind = true
		if count == 4:
			has_four_of_a_kind = true
		if count == 5:
			has_five_of_a_kind = true
		
		if no_of_pairs == 2:
			has_two_pair = true
		
	
	# 5 Card Hands
	if holder.selected.size() == 5:
		
		
		# Check Straight
		
		for i in ranks:
			if ranks.find(i + 1) != -1 and \
				ranks.find(i + 2) != -1 and \
				ranks.find(i + 3) != -1 and \
				ranks.find(i + 4) != -1 :
					is_straight = true
		
		
		# Check Flush
		for suit in CardData.Suit.size():
			
			var cards_of_suit: int = 0
			
			for card in holder.selected:
				if (card.suit) == suit:
					cards_of_suit += 1
			
			if cards_of_suit == 5:
				is_flush = true
		
		if ranks.has(CardData.Rank.TEN) and \
			ranks.has(CardData.Rank.JACK) and \
			ranks.has(CardData.Rank.QUEEN) and \
			ranks.has(CardData.Rank.KING) and \
			ranks.has(CardData.Rank.ACE):
				is_royal = true
	
	
	if has_pair:
		current_hand = CardData.HandType.PAIR
	
	if has_two_pair:
		current_hand = CardData.HandType.TWO_PAIR
	
	if has_three_of_a_kind:
		current_hand = CardData.HandType.THREE_OF_A_KIND
	
	if is_straight:
		current_hand = CardData.HandType.STRAIGHT
	
	if is_flush:
		current_hand = CardData.HandType.FLUSH
	
	if has_pair and has_three_of_a_kind:
		current_hand = CardData.HandType.FULL_HOUSE
	
	if has_three_of_a_kind and has_pair:
		current_hand = CardData.HandType.FULL_HOUSE
	
	if has_four_of_a_kind:
		current_hand = CardData.HandType.FOUR_OF_A_KIND
	
	if is_flush and is_straight:
		current_hand = CardData.HandType.STRAIGHT_FLUSH
	
	if is_flush and is_royal:
		current_hand = CardData.HandType.ROYAL_FLUSH
	
	if has_five_of_a_kind:
		current_hand = CardData.HandType.FIVE_OF_A_KIND
	
	if is_flush and has_three_of_a_kind and has_pair:
		current_hand = CardData.HandType.FLUSH_HOUSE
	
	if is_flush and has_five_of_a_kind:
		current_hand = CardData.HandType.FLUSH_FIVE
	
	
	$HandType.text = "Hand Type:\n%s" % str(CardData.HandType.find_key(current_hand))
