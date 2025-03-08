extends CardHolder

class_name PlayHolder

signal on_finished_scoring

var can_interact: bool = false
@onready var exit_pos: Node2D = $ExitPos
@onready var joker_holder: JokerHolder = $"../Joker"


func score_cards(cards: Array[CardInstance], hand_type: CardData.HandType):
	
	for card in cards:
		card.holder = self
		card.reparent(holder)
		check_cards()
		organize_cards()
		await get_tree().create_timer(0.1).timeout
	
	var played_cards: Array[CardInstance]
	for i in holder.get_children():
		if i is CardInstance:
			played_cards.append(i)
	
	
	# Score cards
	
	#Unscore cards for certain hands
	var scoring_cards: Array[CardInstance]
	
	if hand_type == CardData.HandType.HIGH_CARD:
		var highest_rank: CardInstance
		for card in played_cards:
			if highest_rank != null:
				if highest_rank.rank < card.rank:
					highest_rank = card
			else:
				highest_rank = card
		
		scoring_cards.append(highest_rank)
	
	
	if is_not_scoring_full_hand(hand_type):
		var all_ranks: Array[CardData.Rank]
		for card in played_cards:
			all_ranks.append(card.rank)
		
		var ranks: Array[CardData.Rank]
		for card in played_cards:
			if ranks.find(card.rank) == -1:
				ranks.append(card.rank)
		
		var highest_reoccuring_rank: Array[CardData.Rank]
		var highest_rank_repeats: int = 0
		for rank in ranks:
			
			var current_count: int = 0
			for card_rank in all_ranks:
				if card_rank == rank:
					current_count += 1
			
			if highest_rank_repeats <= current_count:
				
				if current_count != 2:
					highest_reoccuring_rank.clear()
				
				highest_rank_repeats = current_count
				highest_reoccuring_rank.append(rank)
		
		for card in played_cards:
			for rank in highest_reoccuring_rank:
				if card.rank == rank:
					scoring_cards.append(card)
		print("scoring a partial hand")
	elif hand_type != CardData.HandType.HIGH_CARD:
		scoring_cards = played_cards.duplicate()
	
	
	# Scoring
	
	# Raise
	for card in scoring_cards:
		card.position.y -= 30
		await get_tree().create_timer(0.1).timeout
	
	# Shake on score
	for card in scoring_cards:
		Util.chip_alert.activate(card.global_position, "+%s" % card.get_score_chips(), false)
		Util.scoring_box.add_chips(card.get_score_chips())
		
		card.shake_card()
		
		for joker in joker_holder.cards:
			if joker is JokerInstance:
				await joker.ability._on_card_scored(card)
		
		await get_tree().create_timer(0.2).timeout
	
	played_cards.reverse()
	
	await get_tree().create_timer(0.5).timeout
	
	on_finished_scoring.emit()


func is_not_scoring_full_hand(handtype: CardData.HandType) -> bool:
	return handtype == CardData.HandType.PAIR or \
		handtype == CardData.HandType.TWO_PAIR or \
		handtype == CardData.HandType.THREE_OF_A_KIND or \
		handtype == CardData.HandType.FOUR_OF_A_KIND


func clear_played_cards(cards: Array[CardInstance]):
	
	var played_cards: Array[CardInstance]
	for i in holder.get_children():
		if i is CardInstance:
			played_cards.append(i)
	
	for card in played_cards:
		
		if card is CardInstance:
			
			card.position = exit_pos.position
			await get_tree().create_timer(0.1).timeout
			card.set_card_visible(false)
			card.reparent(Player)
	
	cards.clear()
