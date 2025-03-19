extends CardHolder

class_name PlayingCardHolder

@onready var draw_pos: Node2D = $DrawPos
@onready var play_holder: PlayHolder = $"../Play"
@onready var joker_holder: JokerHolder = $"../Joker"
@onready var hand_checker: HandChecker = $HandChecker

var can_play_and_discard: bool = true

func _ready() -> void:
	await get_tree().process_frame
	start_game()


func start_game():
	draw_card(10)
	set_holder_hidden(false)


func draw_card(amount: int = 1, from_discard: bool = false):
	
	if can_play_and_discard or from_discard:
		CardData.can_interact = false
		can_play_and_discard = false
		
		for i in amount:
			if Player.available_cards.size() > 0:
				
				var random: int = randi_range(0, Player.available_cards.size() - 1)
				var card: CardInstance = Player.available_cards[random]
				
				card.is_selected = false
				card.reparent(holder)
				card.set_sprite_position(draw_pos.global_position)
				card.set_card_visible(true)
				Player.available_cards.remove_at(random)
				
				check_cards()
				organize_cards()
				await get_tree().create_timer(0.1).timeout
		
		if !from_discard:
			CardData.can_interact = true
	can_play_and_discard = true


func discard_selected():
	
	if can_play_and_discard and selected.size() > 0 and Util.game_manager.discard > 0:
		Util.game_manager.set_discards(Util.game_manager.discard - 1)
		can_play_and_discard = false
		CardData.can_interact = false
		
		if selected.size() > 0:
			
			var temp_selected = selected.duplicate()
			selected.clear()
			hovering.clear()
			
			for card in temp_selected:
				
				card.position = draw_pos.position
				
				cards.remove_at(cards.find(card))
				organize_cards()
				
				await get_tree().create_timer(0.09).timeout
				card.reparent(Player)
				card.set_card_visible(false)
		
		await get_tree().create_timer(0.15).timeout
		
		await draw_card(container_size - cards.size(), true)
		
		CardData.can_interact = true
	
	can_play_and_discard = true


func play_selected():
	if selected.size() > 0 and Util.game_manager.hands > 0:
		Util.game_manager.set_hands(Util.game_manager.hands - 1)
		CardData.can_interact = false
		can_play_and_discard = false
		
		var temp_selected = selected.duplicate()
		selected.clear()
		
		for card in temp_selected:
			
			cards.remove_at(cards.find(card))
		
		play_holder.score_cards(temp_selected, $HandChecker.current_hand)
		
		await play_holder.on_finished_scoring
		
		await joker_holder.score_jokers()
		
		await get_tree().create_timer(0.2).timeout
		
		await play_holder.clear_played_cards(temp_selected)
		
		Util.scoring_box.calculate_score()
		
		if Util.game_manager.pre_round_score >= Util.game_manager.blind_panel.blind_goal:
			selected.clear()
			cards.reverse()
			for card in cards:
				card.position = draw_pos.position
				
				await get_tree().create_timer(0.09).timeout
				card.reparent(Player)
				card.set_card_visible(false)
			cards.clear()
			
			set_holder_hidden(true)
			
			await get_tree().create_timer(0.5).timeout
			
			Util.end_reward_panel.set_panel_visible(true)
			await get_tree().create_timer(0.5).timeout
			Util.end_reward_panel.get_end_rewards()
		else:
			await draw_card(container_size - cards.size(), true)
		
		
		CardData.can_interact = true
		can_play_and_discard = true


func _on_card_enter_holder(node: Node) -> void:
	if node is CardInstance:
		node.holder = self
