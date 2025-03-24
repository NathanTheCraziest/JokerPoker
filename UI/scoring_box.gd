extends HBoxContainer

class_name ScoringBox

@onready var chip_label: Label = $Chip/Label
@onready var mult_label: Label = $Mult/Label
@onready var turn_score: Label = $"../HandData/TurnScore"
@onready var hand_level: Label = $"../HandData/HandLevel"
@onready var hand_name: Label = $"../HandData/HandName"
@onready var chip_fire: ColorRect = $Chip/Fire
@onready var mult_fire: ColorRect = $Mult/Fire

var chips: float = 0
var mult: float = 0

func _ready() -> void:
	Util.scoring_box = self

func add_chips(amount: float):
	chips += amount
	chip_label.text = Util.thousands_sep(chips)
	
	var tween: Tween = create_tween()
	chip_label.scale = Vector2(1.3, 1.3)
	chip_label.rotation_degrees = randf_range(-10, 10)
	tween.tween_property(chip_label, "rotation_degrees", 0, 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(chip_label, "scale", Vector2(1, 1), 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel()
	
	check_score_higher_than_goal()

func add_mult(amount: float):
	mult += amount
	mult_label.text = Util.thousands_sep(mult)
	
	var tween: Tween = create_tween()
	mult_label.scale = Vector2(1.3, 1.3)
	mult_label.rotation_degrees = randf_range(-10, 10)
	tween.tween_property(mult_label, "rotation_degrees", 0, 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(mult_label, "scale", Vector2(1, 1), 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel()
	
	check_score_higher_than_goal()

func x_mult(amount: float):
	mult *= amount
	mult_label.text = Util.thousands_sep(mult)
	
	var tween: Tween = create_tween()
	mult_label.scale = Vector2(1.3, 1.3)
	mult_label.rotation_degrees = randf_range(-10, 10)
	tween.tween_property(mult_label, "rotation_degrees", 0, 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(mult_label, "scale", Vector2(1, 1), 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel()
	
	check_score_higher_than_goal()

func set_hand_base(poker_hand: PokerHand):
	
	chips = poker_hand.chips
	chip_label.text = Util.thousands_sep(chips)
	mult = poker_hand.mult
	mult_label.text = Util.thousands_sep(mult)
	
	shake_chip()
	
	shake_mult()
	
	check_score_higher_than_goal()

func upgrade_hand(poker_hand: PokerHand, up_chips: float, up_mult: float):
	show_hand_data()
	chip_label.text = Util.thousands_sep(poker_hand.chips)
	mult_label.text = Util.thousands_sep(poker_hand.mult)
	hand_name.text = poker_hand.hand_name
	hand_level.text = "Lvl.%s" % poker_hand.level
	shake_chip()
	shake_mult()
	
	poker_hand.chips += up_chips
	poker_hand.mult += up_mult
	poker_hand.level += 1
	
	await get_tree().create_timer(0.2).timeout
	
	mult_label.text = Util.thousands_sep(poker_hand.mult)
	shake_mult()
	
	await get_tree().create_timer(0.2).timeout
	
	mult_label.text = Util.thousands_sep(poker_hand.chips)
	shake_chip()
	
	await get_tree().create_timer(0.2).timeout
	
	hand_level.text = "Lvl.%s" % (poker_hand.level)
	
	await get_tree().create_timer(0.2).timeout
	if Util.game_manager.hand_holder.selected.size() > 0:
		print("previous hand")
		var old_poker_hand: PokerHand = Player.poker_hands.get($"../../../Hand/HandChecker".current_hand)
		set_hand_base(old_poker_hand)
		hand_level.text = "Lvl.%s" % (old_poker_hand.level)
		hand_name.text = old_poker_hand.hand_name
	else:
		print("nothing")
		show_score()
		chip_label.text = "0"
		mult_label.text = "0"


func shake_chip():
	var tween: Tween = create_tween()
	chip_label.scale = Vector2(1.3, 1.3)
	chip_label.rotation_degrees = randf_range(-10, 10)
	tween.tween_property(chip_label, "rotation_degrees", 0, 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(chip_label, "scale", Vector2(1, 1), 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel()

func shake_mult():
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
	Util.game_manager.pre_round_score += score
	
	turn_score.text =  Util.thousands_sep(score)
	
	hide_fire()
	
	turn_score.visible_characters = 0
	show_score()
	
	for i in turn_score.text.length():
		turn_score.visible_characters = i
		await get_tree().create_timer(0.01).timeout
	turn_score.visible_characters = -1
	
	await get_tree().create_timer(0.2).timeout
	
	var tween: Tween = create_tween()
	tween.tween_method(set_round_score_text, score, 0, 0.5)
	
	Util.game_manager.add_round_score(score)

func show_hand_data():
	hand_level.show()
	hand_name.show()
	turn_score.hide()

func show_score():
	hand_level.hide()
	hand_name.hide()
	turn_score.show()


var is_goal_reached: bool = false

func check_score_higher_than_goal():
	if mult * chips >= Util.game_manager.blind_panel.blind_goal:
		
		chip_fire.show()
		mult_fire.show()
		
		if !is_goal_reached:
			is_goal_reached = true
			
			var tween: Tween = create_tween()
			
			tween.tween_method(set_fire_intensity, 0.3, 0.55, 1.0)
	else:
		var tween: Tween = create_tween()
			
		tween.tween_method(set_fire_intensity, 0.3, 0.55, 1.0)


func set_fire_intensity(arg: float):
	chip_fire.material.set_shader_parameter("spread", arg)
	mult_fire.material.set_shader_parameter("spread", arg)

func hide_fire():
	if is_goal_reached:
			is_goal_reached = false
			
			var tween: Tween = create_tween()
			
			tween.tween_method(set_fire_intensity, 0.55, 0, 1.0)
			await tween.finished
			chip_fire.hide()
			mult_fire.hide()

func set_round_score_text(score: float):
	turn_score.text = Util.thousands_sep(roundi(score))
