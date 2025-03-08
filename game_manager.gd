extends Node2D

class_name GameManager

@onready var blind_panel: BlindManager = $UI/Panel/BlindPanel
@onready var round_score_label: Label = $UI/Panel/RoundScore/ScorePanel/HBoxContainer/Label
@onready var hands_label: Label = $UI/Panel/Hands/ScorePanel/Tip
@onready var discards_label: Label = $UI/Panel/Discards/ScorePanel/Tip
@onready var money_label: Label = $UI/Panel/Money/ScorePanel/Tip
var round_score: float = 0.0
var pre_round_score: float = 0.0

var hands: int = 0
var discard: int = 0
var money: int = 0


func _ready() -> void:
	Util.game_manager = self
	set_hands(Player.max_hands)
	set_discards(Player.max_discards)
	set_money(Player.money)


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
	return money <= arg


func add_round_score(score: float):
	var tween: Tween = create_tween()
	
	tween.tween_method(set_round_score_text, round_score, round_score + score, 0.5)
	round_score += score
	
	await tween.finished
	
	if round_score >= blind_panel.blind_goal:
		print("You won!")


func set_round_score_text(score: float):
	round_score_label.text = Util.thousands_sep(roundi(score))
