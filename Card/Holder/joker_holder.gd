extends CardHolder

signal _jokers_done_scoring

func _on_card_enter_holder(node: Node) -> void:
	if node is JokerInstance:
		node.holder = self
