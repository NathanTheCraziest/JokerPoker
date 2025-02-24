extends CardHolder

func _on_card_enter_holder(node: Node) -> void:
	if node is JokerInstance:
		node.holder = self
