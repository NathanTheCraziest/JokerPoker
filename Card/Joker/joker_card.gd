extends CardInstance

class_name JokerInstance

var ability: JokerAbility = null

@export var ability_id: String

func _ready() -> void:
	if Jokers.abilities.get(ability_id) == null:
		ability = load("res://Card/Joker/Abilities/jimbo.gd").new()
	else:
		ability = load(Jokers.abilities.get(ability_id)).new()
	add_child(ability)
	update_sprite()

func update_sprite():
	content.region_rect.position.x = 23 * ability.get_texture_index()


func on_select():
	
	if holder.selected.size() > 0 and !is_selected:
		for card in holder.selected:
			card.is_selected = false
			holder.remove_selected(card)
		is_selected = !is_selected
	else:
		is_selected = !is_selected
	
	
	if is_selected:
		
		holder.add_selected(self)
		
	else:
		
		holder.remove_selected(self)
