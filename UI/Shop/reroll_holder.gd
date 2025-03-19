extends CardHolder

class_name RerollHolder


func _ready() -> void:
	add_random_cards()


func add_random_cards():
	for i in 3:
		var new_joker: JokerInstance = Jokers.create_joker(Jokers.abilities.keys().pick_random())
		holder.add_child(new_joker)
	check_cards()
	organize_cards()
	
