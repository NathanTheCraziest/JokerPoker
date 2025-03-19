extends Node2D

class_name Shop

var shop_hidden: bool = true

@export var show_position: Vector2
@export var hide_position: Vector2


func _ready() -> void:
	Util.shop = self


func set_shop_hidden(arg: bool):
	shop_hidden = arg
	
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", show_position if !shop_hidden else hide_position, 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)


func _on_next_button_down() -> void:
	Util.game_manager.advance_blind()
	Util.game_manager.blind_panel.update_blind()
	set_shop_hidden(true)
	Util.game_manager.hand_holder.start_game()
	Util.game_manager.blind_panel.set_panel_visible(true)
