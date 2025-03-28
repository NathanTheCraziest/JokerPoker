extends ConsumableInstsance

class_name PlanetInstance

@export var planet: CardData.Planet

func update_sprite():
	content.region_rect.position.x = 23 * planet

func on_use() -> bool:
	
	match(planet):
		CardData.Planet.MERCURY:
			return await upgrade_poker_hand(CardData.HandType.PAIR, 15, 1)
		
		CardData.Planet.VENUS:
			return await upgrade_poker_hand(CardData.HandType.THREE_OF_A_KIND, 20, 2)
		
		CardData.Planet.EARTH:
			return await upgrade_poker_hand(CardData.HandType.FULL_HOUSE, 25, 2)
		
		CardData.Planet.MARS:
			return await upgrade_poker_hand(CardData.HandType.FOUR_OF_A_KIND, 30, 3)
		
		CardData.Planet.JUPITER:
			return await upgrade_poker_hand(CardData.HandType.FLUSH, 15, 2)
		
		CardData.Planet.SATURN:
			return await upgrade_poker_hand(CardData.HandType.STRAIGHT, 30, 3)
		
		CardData.Planet.URANUS:
			return await upgrade_poker_hand(CardData.HandType.TWO_PAIR, 20, 1)
			
		CardData.Planet.NEPTUNE:
			return await upgrade_poker_hand(CardData.HandType.STRAIGHT_FLUSH, 40, 4)
			
		CardData.Planet.PLUTO:
			return await upgrade_poker_hand(CardData.HandType.HIGH_CARD, 10, 1)
			
		CardData.Planet.PLANETX:
			return await upgrade_poker_hand(CardData.HandType.FIVE_OF_A_KIND, 35, 3)
			
		CardData.Planet.CERES:
			return await upgrade_poker_hand(CardData.HandType.FLUSH_HOUSE, 40, 4)
		
		CardData.Planet.ERIS:
			return await upgrade_poker_hand(CardData.HandType.FLUSH_FIVE, 50, 3)
	
	return false


func upgrade_poker_hand(hand: CardData.HandType, chips: float, mult: float) -> bool:
	CardData.can_interact = false
	Util.scoring_box.upgrade_hand(Player.poker_hands.get(hand), chips, mult)
	await get_tree().create_timer(0.2).timeout
	shake_card()
	await get_tree().create_timer(0.2).timeout
	shake_card()
	await get_tree().create_timer(0.2).timeout
	shake_card()
	await get_tree().create_timer(0.2).timeout
	return true

func get_tip_message() -> String:
	match(planet):
		CardData.Planet.MERCURY:
			return "[center][color=black]Mercury[/color]
[color=red]+%s Mult[/color] [color=dodger_blue]+%s Chips[/color]
[color=gray]%s[/color][/center]
" % [1, 15, "Pair"]
		
		CardData.Planet.VENUS:
			return "[center][color=black]Venus[/color]
[color=red]+%s Mult[/color] [color=dodger_blue]+%s Chips[/color]
[color=gray]%s[/color][/center]
" % [2, 20, "Three of a Kind"]
		
		CardData.Planet.EARTH:
			return "[center][color=black]Earth[/color]
[color=red]+%s Mult[/color] [color=dodger_blue]+%s Chips[/color]
[color=gray]%s[/color][/center]
" % [2, 25, "Full House"]
		
		CardData.Planet.MARS:
			return "[center][color=black]Mars[/color]
[color=red]+%s Mult[/color] [color=dodger_blue]+%s Chips[/color]
[color=gray]%s[/color][/center]
" % [3, 30, "Four of a Kind"]
		
		CardData.Planet.JUPITER:
			return "[center][color=black]Jupiter[/color]
[color=red]+%s Mult[/color] [color=dodger_blue]+%s Chips[/color]
[color=gray]%s[/color][/center]
" % [2, 15, "Flush"]
		
		CardData.Planet.SATURN:
			return "[center][color=black]Saturn[/color]
[color=red]+%s Mult[/color] [color=dodger_blue]+%s Chips[/color]
[color=gray]%s[/color][/center]
" % [3, 30, "Straight"]
		
		CardData.Planet.URANUS:
			return "[center][color=black]Uranus[/color]
[color=red]+%s Mult[/color] [color=dodger_blue]+%s Chips[/color]
[color=gray]%s[/color][/center]
" % [1, 20, "Two Pair"]
			
		CardData.Planet.NEPTUNE:
			return "[center][color=black]Neptune[/color]
[color=red]+%s Mult[/color] [color=dodger_blue]+%s Chips[/color]
[color=gray]%s[/color][/center]
" % [4, 40, "Straight Flush"]
			
		CardData.Planet.PLUTO:
			return "[center][color=black]Pluto[/color]
[color=red]+%s Mult[/color] [color=dodger_blue]+%s Chips[/color]
[color=gray]%s[/color][/center]
" % [1, 10, "High Card"]
			
		CardData.Planet.PLANETX:
			return "[center][color=black]Planet X[/color]
[color=red]+%s Mult[/color] [color=dodger_blue]+%s Chips[/color]
[color=gray]%s[/color][/center]
" % [3, 35, "Five of a Kind"]
			
		CardData.Planet.CERES:
			return "[center][color=black]Ceres[/color]
[color=red]+%s Mult[/color] [color=dodger_blue]+%s Chips[/color]
[color=gray]%s[/color][/center]
" % [4, 40, "Ceres"]
		
		CardData.Planet.ERIS:
			return "[center][color=black]Eris[/color]
[color=red]+%s Mult[/color] [color=dodger_blue]+%s Chips[/color]
[color=gray]%s[/color][/center]
" % [3, 50, "Flush Five"]
	return ""
