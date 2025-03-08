extends Panel

class_name EndRewardPanel

const reward_prefab: PackedScene = preload("res://UI/Reward/end_reward.tscn")
@onready var holder: VBoxContainer = $VBoxContainer
@onready var cash_out: Button = $Button


var is_panel_visible: bool = false
var cash_out_value: int = 0
var can_cash_out: bool = false

func _ready() -> void:
	Util.end_reward_panel = self


func set_panel_visible(arg: bool):
	is_panel_visible = arg
	
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", Vector2(350, 230) if is_panel_visible else Vector2(350, 700), 0.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	
	await tween.finished
	if !is_panel_visible:
		for child in holder.get_children():
			child.queue_free()


func add_reward(reason: String, amount: int):
	var new_reward: EndReward = reward_prefab.instantiate()
	
	holder.add_child(new_reward)
	await new_reward.set_reward_message(reason, amount)
	await get_tree().create_timer(0.5).timeout


func get_end_rewards():
	can_cash_out = false
	
	cash_out_value = 0
	cash_out.text = "Cash out"
	
	
	
	await add_reward("Blind Reward", Util.game_manager.blind_panel.blind_reward)
	cash_out_value += Util.game_manager.blind_panel.blind_reward
	
	if Util.game_manager.hands > 0:
		await add_reward("%s Hands remaining ($1 each)" % Util.game_manager.hands, Util.game_manager.hands)
	cash_out_value += Util.game_manager.hands
	
	await get_tree().create_timer(0.2).timeout
	cash_out.text = "Cash out: $%s" % str(cash_out_value)
	can_cash_out = true


func _on_cash_out_button_down() -> void:
	if can_cash_out:
		can_cash_out = false
		Util.game_manager.add_money(cash_out_value)
		set_panel_visible(false)
