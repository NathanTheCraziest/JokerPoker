extends Node2D

class_name GameManager

@onready var blind_panel: BlindManager = $UI/Panel/BlindPanel
@onready var round_score_label: Label = $UI/Panel/RoundScore/ScorePanel/HBoxContainer/Label
@onready var hands_label: Label = $UI/Panel/Hands/ScorePanel/Tip
@onready var discards_label: Label = $UI/Panel/Discards/ScorePanel/Tip
@onready var money_label: Label = $UI/Panel/Money/ScorePanel/Tip
@onready var joker_holder: JokerHolder = $Joker
@onready var ante_label: Label = $UI/Panel/Ante/ScorePanel/Tip
@onready var hand_holder: PlayingCardHolder = $Hand
var round_score: float = 0.0
var pre_round_score: float = 0.0

var current_ante: int = 1
var blind_no: int = 1

var hands: int = 0
var discard: int = 0
var money: int = 0


func advance_blind():
	blind_no += 1
	if blind_no > 3:
		blind_no = 1
		current_ante += 1
	ante_label.text = "%s/8" % current_ante


func _ready() -> void:
	Util.game_manager = self
	reset_on_win()
	set_money(Player.money)


func reset_on_win():
	set_hands(Player.max_hands)
	set_discards(Player.max_discards)
	round_score = 0.0
	pre_round_score = 0.0
	round_score_label.text = Util.thousands_sep(roundi(round_score))


func set_hands(arg: int):
	hands = arg
	hands_label.text = str(hands)


func set_discards(arg: int):
	discard = arg
	discards_label.text = str(discard)


func set_money(arg: int):
	money = arg
	money_label.text = "$%s" % str(money)


func add_money(arg: int):
	set_money(money + arg)


func can_afford(arg: int) -> bool:
	return money >= arg


func add_round_score(score: float):
	var tween: Tween = create_tween()
	
	tween.tween_method(set_round_score_text, round_score, round_score + score, 0.5)
	round_score += score
	
	await tween.finished


func set_round_score_text(score: float):
	round_score_label.text = Util.thousands_sep(roundi(score))
