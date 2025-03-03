extends HBoxContainer

class_name ScoringBox

@onready var chip_label: Label = $Chip/Label
@onready var mult_label: Label = $Mult/Label
@onready var turn_score: Label = $"../HandData/TurnScore"
@onready var hand_level: Label = $"../HandData/HandLevel"
@onready var hand_name: Label = $"../HandData/HandName"

var chips: float = 0
var mult: float = 0

func _ready() -> void:
	Util.scoring_box = self

func add_chips(amount: float):
	chips += amount
	chip_label.text = str(chips)
	
	var tween: Tween = create_tween()
	chip_label.scale = Vector2(1.3, 1.3)
	chip_label.rotation_degrees = randf_range(-10, 10)
	tween.tween_property(chip_label, "rotation_degrees", 0, 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(chip_label, "scale", Vector2(1, 1), 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel()

func add_mult(amount: float):
	mult += amount
	mult_label.text = str(mult)
	
	var tween: Tween = create_tween()
	mult_label.scale = Vector2(1.3, 1.3)
	mult_label.rotation_degrees = randf_range(-10, 10)
	tween.tween_property(mult_label, "rotation_degrees", 0, 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(mult_label, "scale", Vector2(1, 1), 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel()

func x_mult(amount: float):
	mult *= amount
	mult_label.text = str(mult)
	
	var tween: Tween = create_tween()
	mult_label.scale = Vector2(1.3, 1.3)
	mult_label.rotation_degrees = randf_range(-10, 10)
	tween.tween_property(mult_label, "rotation_degrees", 0, 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(mult_label, "scale", Vector2(1, 1), 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel()

func set_hand_base(poker_hand: PokerHand):
	chips = poker_hand.chips
	chip_label.text = str(chips)
	mult = poker_hand.mult
	mult_label.text = str(mult)
	
	var tween: Tween = create_tween()
	chip_label.scale = Vector2(1.3, 1.3)
	chip_label.rotation_degrees = randf_range(-10, 10)
	tween.tween_property(chip_label, "rotation_degrees", 0, 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(chip_label, "scale", Vector2(1, 1), 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel()
	
	var tween_: Tween = create_tween()
	mult_label.scale = Vector2(1.3, 1.3)
	mult_label.rotation_degrees = randf_range(-10, 10)
	tween_.tween_property(mult_label, "rotation_degrees", 0, 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween_.tween_property(mult_label, "scale", Vector2(1, 1), 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	tween_.parallel()

func clear_hand():
	mult = 0
	chips = 0
	mult_label.text = str(mult)
	chip_label.text = str(chips)

func calculate_score():
	var score: float = chips * mult
	
	show_score()
	
	turn_score.text = str(score)

func show_hand_data():
	hand_level.show()
	hand_name.show()
	turn_score.hide()

func show_score():
	hand_level.hide()
	hand_name.hide()
	turn_score.show()
