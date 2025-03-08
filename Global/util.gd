extends Node

var scoring_box: ScoringBox = null
var mult_alert: ScoreAlert = null
var chip_alert: ScoreAlert = null
var game_manager: GameManager = null
var sell_button: SellButton = null
var end_reward_panel: EndRewardPanel = null

var just_sold: bool = false

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
