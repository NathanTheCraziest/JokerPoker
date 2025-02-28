extends HBoxContainer

class_name ScoringBox

@onready var chip_label: Label = $Chip/Label
@onready var mult_label: Label = $Mult/Label
@onready var turn_score: Label = $"../TurnScore"

var chips: float = 0
var mult: float = 0

func _ready() -> void:
	Util.scoring_box = self

func add_chips(amount: float):
	chips += amount
	chip_label.text = str(chips)
	
	var tween: Tween = create_tween()
	tween.tween_property(mult_label, "rotation_degrees", 3, 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(mult_label, "rotation_degrees", 0, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)

func add_mult(amount: float):
	mult += amount
	mult_label.text = str(mult)
	
	var tween: Tween = create_tween()
	tween.tween_property(mult_label, "rotation_degrees", 3, 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(mult_label, "rotation_degrees", 0, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)

func x_mult(amount: float):
	mult *= amount
	mult_label.text = str(mult)
	
	var tween: Tween = create_tween()
	tween.tween_property(mult_label, "rotation", 3, 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(mult_label, "rotation", 0, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)

func set_hand_base(poker_hand: PokerHand):
	chips = poker_hand.chips
	chip_label.text = str(chips)
	mult = poker_hand.mult
	mult_label.text = str(mult)
	
	var tween: Tween = create_tween()
	tween.tween_property(mult_label, "rotation", 3, 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(mult_label, "rotation", 0, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	
	var tween_: Tween = create_tween()
	tween_.tween_property(chip_label, "rotation", 3, 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween_.tween_property(chip_label, "rotation", 0, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)

func calculate_score():
	var score: float = chips * mult
	
	turn_score.text = str(score)
