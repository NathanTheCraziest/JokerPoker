extends CardInstance

class_name JokerInstance

var ability: JokerAbility = null

@export var ability_id: String

func _ready() -> void:
	ability = JokerAbility.new()
	add_child(ability)
	if Jokers.abilities.get(ability_id) == null:
		ability.set_script(Jokers.abilities.get("jimbo"))
	else:
		ability.set_script(Jokers.abilities.get(ability_id))
