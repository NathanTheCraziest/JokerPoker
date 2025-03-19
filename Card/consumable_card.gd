extends CardInstance

class_name ConsumableInstsance


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
		if holder is RerollHolder:
			if Util.buy_button != null:
				Util.buy_button.selected_card = self
				Util.buy_button.show()
				Util.buy_button.reparent($Node/Base, 1)
				Util.buy_button.scale = Vector2(1, 1)
				Util.buy_button.rotation = 0
				Util.buy_button.position = Vector2.ZERO
				Util.buy_button.position.x = 10
				Util.buy_button.update_text()
		else:
			if Util.sell_button != null:
				Util.sell_button.selected_card = self
				Util.sell_button.show()
				Util.sell_button.reparent($Node/Base, 1)
				Util.sell_button.scale = Vector2(1, 1)
				Util.buy_button.rotation = 0
				Util.sell_button.position.y = -5
				Util.sell_button.position.x = 10
			
			if Util.use_button != null:
				Util.use_button.selected_card = self
				Util.use_button.show()
				Util.use_button.reparent($Node/Base, 1)
				Util.use_button.scale = Vector2(1, 1)
				Util.use_button.position.y = 5
				Util.use_button.position.x = 10
		
	else:
		
		$Node/Base.z_index = 2 + get_index()
		
		holder.remove_selected(self)
		if Util.sell_button != null:
			Util.sell_button.reparent(Util.game_manager)
			Util.sell_button.hide()
		if Util.buy_button != null:
			Util.buy_button.reparent(Util.game_manager)
			Util.buy_button.hide()
		if Util.use_button != null:
			Util.use_button.reparent(Util.game_manager)
			Util.use_button.hide()


func on_use() -> bool:
	return false
