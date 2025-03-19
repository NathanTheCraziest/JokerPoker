extends ConsumableInstsance

class_name TarotInstance

@export var tarot: CardData.Tarot

func update_sprite():
	content.region_rect.position.x = 23 * tarot

func on_use() -> bool:
	
	match(tarot):
		CardData.Tarot.MAGICIAN:
			return attempt_chance_enhancement(CardData.Enhancement.LUCKY, 2)
		
		CardData.Tarot.EMPRESS:
			return attempt_chance_enhancement(CardData.Enhancement.MULT, 2)
		
		CardData.Tarot.EMPEROR:
			return true
		
		CardData.Tarot.CHARIOT:
			pass
		
		CardData.Tarot.JUSTICE:
			return attempt_chance_enhancement(CardData.Enhancement.STEEL, 1)
		
		CardData.Tarot.HERMIT:
			Util.game_manager.add_money(clampi(Util.game_manager.money * 2, 0, 20))
			return true
		
		CardData.Tarot.STRENGTH:
			return attempt_increase_rank(2)
		
		CardData.Tarot.TEMPERANCE:
			return true
		
		CardData.Tarot.DEVIL:
			return attempt_chance_enhancement(CardData.Enhancement.GOLD, 1)
		
		CardData.Tarot.TOWER:
			return attempt_chance_enhancement(CardData.Enhancement.STONE, 1)
		
		CardData.Tarot.JUDGEMENT:
			return true
			
		CardData.Tarot.WHEEL:
			return true
		
		CardData.Tarot.FOOL:
			return true
		
		CardData.Tarot.PRIESTESS:
			return true
		
		CardData.Tarot.HANGED:
			return true
			
		CardData.Tarot.SUN:
			return attempt_chance_suit(CardData.Suit.HEART, 3)
			
		CardData.Tarot.HIEROPHANT:
			return attempt_chance_enhancement(CardData.Enhancement.BONUS, 2)
		
		CardData.Tarot.STAR:
			return attempt_chance_suit(CardData.Suit.DIAMOND, 3)
		
		CardData.Tarot.DEATH:
			return true
		
		CardData.Tarot.LOVERS:
			return attempt_chance_enhancement(CardData.Enhancement.WILD, 1)
		
		CardData.Tarot.WORLD:
			return attempt_chance_suit(CardData.Suit.SPADE, 3)
		
		CardData.Tarot.MOON:
			return attempt_chance_suit(CardData.Suit.CLUB, 3)
	
	return false


func attempt_chance_enhancement(enhancement: CardData.Enhancement, max_cards: int) -> bool:
	if Util.game_manager.hand_holder.selected.size() >= max_cards:
		
		for card in Util.game_manager.hand_holder.selected:
			card.enhancement = enhancement
			card.update_sprite()
			card.shake_card()
		
		Util.game_manager.hand_holder.hand_checker.on_hand_changed()
		return true
	else:
		return false

func attempt_chance_suit(suit: CardData.Suit, max_cards: int) -> bool:
	if Util.game_manager.hand_holder.selected.size() >= max_cards:
		
		for card in Util.game_manager.hand_holder.selected:
			card.suit = suit
			card.update_sprite()
			card.shake_card()
		
		Util.game_manager.hand_holder.hand_checker.on_hand_changed()
		return true
	else:
		return false

func attempt_increase_rank(max_cards: int) -> bool:
	if Util.game_manager.hand_holder.selected.size() >= max_cards:
		
		for card in Util.game_manager.hand_holder.selected:
			
			var next_rank: int = card.rank + 1
			if next_rank > CardData.Rank.KING:
				next_rank = 0
			card.rank = next_rank
			card.update_sprite()
			card.shake_card()
		
		Util.game_manager.hand_holder.hand_checker.on_hand_changed()
		return true
	else:
		return false

func get_tip_message() -> String:
	match(tarot):
		CardData.Tarot.MAGICIAN:
			return "[center][color=black]The Magician[/color]
[color=gray]Enhances 2 selected cards to Lucky Cards[/color][/center]
"
		
		CardData.Tarot.EMPRESS:
			return "[center][color=black]The Empress[/color]
[color=gray]Enhances 2 selected cards to Mult Cards[/color][/center]
"
		
		CardData.Tarot.EMPEROR:
			return "[center][color=black]The Emperor[/color]
[color=gray]Creates up to 2 random Tarot cards[/color][/center]
"
		
		CardData.Tarot.CHARIOT:
			return "[center][color=black]The Chariot[/color]
[color=gray]Enhances 1 selected cards to Steel Cards[/color][/center]
"
		
		CardData.Tarot.JUSTICE:
			return "[center][color=black]Justice[/color]
[color=gray]Enhances 1 selected cards to Glass Cards[/color][/center]"
		
		CardData.Tarot.HERMIT:
			return "[center][color=black]The Hermit[/color]
[color=gray]Doubles money
(Max of $20)[/color][/center]"
		
		CardData.Tarot.STRENGTH:
			return "[center][color=black]Strength[/color]
[color=gray]Increases rank of up to 2 selected cards by 1)[/color][/center]"
		
		CardData.Tarot.TEMPERANCE:
			return "[center][color=black]Temperance[/color]
[color=gray]Gives the total sell value of all current Jokers
(Max of $50)[/color][/center]"
		
		CardData.Tarot.DEVIL:
			return "[center][color=black]The Devil[/color]
[color=gray]Enhances 1 selected cards to Gold Cards[/color][/center]"
		
		CardData.Tarot.TOWER:
			return "[center][color=black]The Tower[/color]
[color=gray]Enhances 1 selected cards to Stone Cards[/color][/center]"
		
		CardData.Tarot.JUDGEMENT:
			return "[center][color=black]Judgement[/color]
[color=gray]Creates a random Joker[/color][/center]"
			
		CardData.Tarot.WHEEL:
			return "[center][color=black]The Wheel[/color]
[color=gray]1 in 4 chance to do Nothing[/color][/center]"
		
		CardData.Tarot.FOOL:
			return "[center][color=black]The Fool[/color]
[color=gray]Creates last used consumable
(Fool excluded)[/color][/center]"
		
		CardData.Tarot.PRIESTESS:
			return "[center][color=black]The High Priestess[/color]
[color=gray]Creates up to 2 random Planet cards[/color][/center]"
		
		CardData.Tarot.HANGED:
			return "[center][color=black]The Hanged Man[/color]
[color=gray]Destroys up to 2 selected cards[/color][/center]"
			
		CardData.Tarot.SUN:
			return "[center][color=black]The Sun[/color]
[color=gray]Converts up to 3 selected cards to Hearts[/color][/center]"
			
		CardData.Tarot.HIEROPHANT:
			return "[center][color=black]Hierophant[/color]
[color=gray]Enhances 2 selected cards to Bonus Cards[/color][/center]"
		
		CardData.Tarot.STAR:
			return "[center][color=black]The Star[/color]
[color=gray]Converts up to 3 selected cards to Diamonds[/color][/center]"
		
		CardData.Tarot.DEATH:
			return "[center][color=black]Death[/color]
[color=gray]Select 2 cards, convert the left card into the right card[/color][/center]"
		
		CardData.Tarot.LOVERS:
			return "[center][color=black]The Lovers[/color]
[color=gray]	Enhances 1 selected card into a Wild Card[/color][/center]"
		
		CardData.Tarot.WORLD:
			return "[center][color=black]The World[/color]
[color=gray]Converts up to 3 selected cards to Spades[/color][/center]"
		
		CardData.Tarot.MOON:
			return "[center][color=black]The Moon[/color]
[color=gray]Converts up to 3 selected cards to Clubs[/color][/center]"
	
	return "nothing"
