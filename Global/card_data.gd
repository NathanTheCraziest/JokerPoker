extends Node

enum Suit {HEART, SPADE, DIAMOND, CLUB}
enum Rank {ACE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING}
enum Type {PLAYING, JOKER, TAROT, PLANET}
enum HandType {HIGH_CARD, PAIR, TWO_PAIR, THREE_OF_A_KIND, STRAIGHT, FLUSH, FULL_HOUSE, FOUR_OF_A_KIND, STRAIGHT_FLUSH, ROYAL_FLUSH, FIVE_OF_A_KIND, FLUSH_HOUSE, FLUSH_FIVE}
enum Enhancement {NONE, BONUS, MULT, WILD, GLASS, STEEL, STONE, GOLD, LUCKY}
enum Tarot {MAGICIAN, EMPRESS, EMPEROR, CHARIOT, JUSTICE, HERMIT, STRENGTH, TEMPERANCE, DEVIL, TOWER, JUDGEMENT, WHEEL, FOOL, PRIESTESS, HANGED, SUN, HIEROPHANT, STAR, DEATH, LOVERS, WORLD, MOON}

var can_interact: bool = true

func create_playing_card(rank: CardData.Rank, suit: CardData.Suit) -> CardInstance:
	var new_card: CardInstance = preload("res://Card/card.tscn").instantiate()
	new_card.rank = rank
	new_card.suit = suit
	new_card.set_card_visible(false)
	Player.add_child(new_card)
	new_card.update_sprite()
	return new_card
