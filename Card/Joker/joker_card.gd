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
	
	if holder.selected.size() > 0 and !is_selected and !Util.just_sold:
		for card in holder.selected:
			card.is_selected = false
			holder.remove_selected(card)
		is_selected = !is_selected
	else:
		is_selected = !is_selected
	
	
	if is_selected:
		
		$Node/Base.z_index = 3 + get_parent().get_children().size()
		
		holder.add_selected(self)
		if Util.sell_button != null:
			Util.sell_button.selected_card = self
			Util.sell_button.show()
			Util.sell_button.reparent($Node/Base, 1)
			Util.sell_button.scale = Vector2(1, 1)
			Util.sell_button.position = Vector2.ZERO
			Util.sell_button.position.x = 10
		
	else:
		
		$Node/Base.z_index = 2 + get_index()
		
		holder.remove_selected(self)
		if Util.sell_button != null:
			Util.sell_button.reparent(Util.game_manager)
			Util.sell_button.hide()
