extends Panel

class_name BlindManager

@onready var lblind_name: Label = $BlindName/Label
@onready var lblind_goal: Label = $BlindData/ScorePanel/HBoxContainer/HBoxContainer/Label
@onready var lblind_reward: Label = $BlindData/ScorePanel/HBoxContainer/Reward

var blind_name: String = "Small Blind"
var blind_goal: float = 300.0
var blind_reward: int = 3

func _ready() -> void:
	lblind_name.text = blind_name
	lblind_goal.text = Util.thousands_sep(blind_goal)
	lblind_reward.text = ""
	for i in blind_reward:
		lblind_reward.text += "$"
