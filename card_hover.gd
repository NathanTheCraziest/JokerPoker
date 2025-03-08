extends Area2D

class_name CardInstance


var is_card_hovering: bool = false
var rotation_intensity: float = 5.0

var is_held: bool = false
var held_frames: int = 0

var is_selected: bool = false
var holder: CardHolder = null

@export var card_type: CardData.Type
@export var suit: CardData.Suit
@export var rank: CardData.Rank

var sell_value: int = 1

@onready var sprite: Sprite2D = $Node/Base
@onready var shape: CollisionShape2D = $CollisionShape2D
@onready var content: Sprite2D = $Node/Base/Content


func _ready() -> void:
	update_sprite()


func _process(delta: float) -> void:
	if is_card_hovering:
		var mouse_pos: Vector2 = get_local_mouse_position()
		
		sprite.material.set_shader_parameter("x_rot", ((mouse_pos.y / shape.shape.size.y)) * -rotation_intensity)
		sprite.material.set_shader_parameter("y_rot", ((mouse_pos.x / shape.shape.size.x)) * rotation_intensity)
		
		
		if Input.is_action_just_released("select") and CardData.can_interact and is_held:
			
			if held_frames < 5:
				on_select()
			
			holder.check_cards()
			holder.organize_cards()
			is_held = false
			
		
		
		if Input.is_action_just_pressed("select") and holder.is_highest_hover(self) and CardData.can_interact:
				
				is_held = true
				
		elif is_held:
			held_frames += 1
		else:
			held_frames = 0
		
		
	else:
		sprite.material.set_shader_parameter("x_rot", 0)
		sprite.material.set_shader_parameter("y_rot", 0)
	
	
	if is_held and held_frames > 4 and Input.is_action_pressed("select"):
		
		global_position = get_global_mouse_position()
		reorder_card()
	elif !is_held and held_frames > 4:
		holder.organize_cards()
	
	if Input.is_action_just_released("select"):
		is_held = false
	
	
	sprite.global_position = sprite.global_position.lerp(global_position, 20.0 * delta)


func reorder_card():
	
	if holder != null:
		for i in holder.holder.get_children().size():
			
			var min: float = holder.min.position.x + (holder.space_between_cards() * i)
			var max: float = holder.min.position.x + (holder.space_between_cards() * (i + 1))
			
			if position.x > min and position.x < max:
				holder.holder.move_child(self, i)
				print("Card Pos: %s" % i)


func _on_mouse_entered() -> void:
	
	if holder != null and CardData.can_interact:
		holder.add_hover(self)
		
		is_card_hovering = true
			
			
	elif CardData.can_interact:
		is_card_hovering = true
	sprite.material.set_shader_parameter("inset", 0)


func _on_mouse_exited() -> void:
	
	if holder != null and CardData.can_interact:
		holder.remove_hover(self)
		is_card_hovering = false
	
	sprite.material.set_shader_parameter("inset", 0.02)


func update_sprite():
	content.region_rect.position.x = 23 * rank
	content.region_rect.position.y = 32 * suit


func on_select():

	if !is_selected and holder.selected.size() <= holder.max_selected - 1:
		is_selected = ! is_selected
	elif is_selected:
		is_selected = ! is_selected
	
	
	if is_selected:
		
		holder.add_selected(self)
		
	else:
		
		holder.remove_selected(self)


func randomize_card():
	suit = randi_range(0, CardData.Suit.size() - 1)
	rank = randi_range(0, CardData.Rank.size() - 1)


func set_card_visible(arg: bool):
	$Node/Base.visible = arg
	visible = arg


func set_sprite_position(position: Vector2):
	$Node/Base.position = position


func shake_card():
	
	var tween: Tween = create_tween()
	tween.tween_property($Node/Base, "rotation_degrees", 25, 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property($Node/Base, "rotation_degrees", 0, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)


func get_score_chips() -> float:
	
	if rank >= CardData.Rank.TWO and rank <= CardData.Rank.JACK:
		return rank + 1
	elif rank >= CardData.Rank.JACK and rank <= CardData.Rank.KING:
		return 10.0
	else:
		return 11.0

func update_draw_order():
	if !is_selected:
		sprite.z_index = 2 + get_index()
