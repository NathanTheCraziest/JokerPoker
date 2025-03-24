extends Node

var scoring_box: ScoringBox = null
var mult_alert: ScoreAlert = null
var chip_alert: ScoreAlert = null
var game_manager: GameManager = null
var sell_button: SellButton = null
var end_reward_panel: EndRewardPanel = null
var shop: Shop = null
var buy_button: BuyButton = null
var use_button: UseButton = null
var tip: Tip = null

var just_sold: bool = false

const tarot_scene: PackedScene = preload("res://Card/Tarot/tarot_card.tscn")
const planet_scene: PackedScene = preload("res://Card/Planet/planet_card.tscn")

static func thousands_sep(number, prefix=''):
	number = int(number)
	var neg = false
	if number < 0:
		number = -number
		neg = true
	var string = str(number)
	var mod = string.length() % 3
	var res = ""
	for i in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			res += ","
		res += string[i]
	if neg: res = '-'+prefix+res
	else: res = prefix+res
	return res

func is_rank_higher_than(rank1: CardData.Rank, rank2: CardData.Rank) -> bool:
	var result: bool = false
	
	result = rank1 > rank2
	
	if rank1 == CardData.Rank.ACE and rank2 != CardData.Rank.ACE:
		result = true
	
	if rank2 == CardData.Rank.ACE and rank1 != CardData.Rank.ACE:
		result = false
	
	return result

func create_tarot(effect: CardData.Tarot):
	var new_tarot: TarotInstance = tarot_scene.instantiate()
	
	new_tarot.tarot = effect
	
	return new_tarot

func create_planet(planet: CardData.Planet):
	var new_planet: PlanetInstance = planet_scene.instantiate()
	
	new_planet.planet = planet
	
	return new_planet
