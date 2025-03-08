extends Control

class_name EndReward

@onready var reason: Label = $Reason
@onready var amount: Label = $Amount

func set_reward_message(text: String, money: int):
	
	reason.visible_characters = 0
	reason.text = text
	for i in text.length():
		reason.visible_characters = i
		await get_tree().create_timer(0.5 / text.length()).timeout
	reason.visible_characters = -1
	
	await get_tree().create_timer(0.5).timeout
	
	amount.text = ""
	for i in money:
		amount.text += "$"
		await get_tree().create_timer(0.05).timeout
	reason.visible_characters = -1
