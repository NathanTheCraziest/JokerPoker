extends Panel

class_name BlindManager

@onready var lblind_name: Label = $BlindName/Label
@onready var lblind_goal: Label = $BlindData/ScorePanel/HBoxContainer/HBoxContainer/Label
@onready var lblind_reward: Label = $BlindData/ScorePanel/HBoxContainer/Reward
@onready var round_score: Panel = $"../RoundScore"

@export var show_position: Vector2
@export var hide_position: Vector2

var blind_name: String = "Small Blind"
var blind_goal: float = 300.0
var blind_reward: int = 3

var ante_bases: Array[float] = [300, 800, 2800, 6000, 11000, 20000, 35000, 50000, 110000, 560000, 7200000, 300000000, 47000000000]


var panel_visible: bool = true

func _ready() -> void:
	await get_tree().process_frame
	update_blind()

func update_blind() -> void:
	match(Util.game_manager.blind_no):
		1:
			blind_goal = get_ante_base()
			blind_name = "Small Blind"
		2:
			blind_goal = get_ante_base() * 1.5
			blind_name = "Big Blind"
		3:
			blind_goal = get_ante_base() * 2.0
			blind_name = "Boss Blind"
	
	lblind_name.text = blind_name
	lblind_goal.text = Util.thousands_sep(blind_goal)
	lblind_reward.text = ""
	for i in blind_reward:
		lblind_reward.text += "$"


func get_ante_base() -> int:
	if Util.game_manager.current_ante - 1 < ante_bases.size() - 1:
		return ante_bases[Util.game_manager.current_ante - 1]
	else:
		return 29000000000000

func _process(delta: float) -> void:
	round_score.position.y = position.y + 175

func set_panel_visible(arg: bool):
	panel_visible = arg
	
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", show_position if arg else hide_position, 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
