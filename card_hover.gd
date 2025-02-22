extends Area2D

class_name CardInstance


var is_card_hovering: bool = false
var rotation_intensity: float = 5.0

var is_selected: bool = false
var holder: CardHolder = null

@export var card_type: CardData.Type
@export var suit: CardData.Suit
@export var rank: CardData.Rank

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
		
		if Input.is_action_just_pressed("select") and holder.is_highest_hover(get_index()) and CardData.can_interact:
				on_select()
		
	else:
		sprite.material.set_shader_parameter("x_rot", 0)
		sprite.material.set_shader_parameter("y_rot", 0)
	
	sprite.global_position = sprite.global_position.lerp(global_position, 20.0 * delta)


func _on_mouse_entered() -> void:
	
	if holder != null and CardData.can_interact:
		holder.add_hover(get_index())
		
		is_card_hovering = true
			
			
	elif CardData.can_interact:
		is_card_hovering = true
	material.set_shader_parameter("inset", 0)


func _on_mouse_exited() -> void:
	
	if holder != null and CardData.can_interact:
		holder.remove_hover(get_index())
		is_card_hovering = false
	
	material.set_shader_parameter("inset", 0.02)


func update_sprite():
	content.region_rect.position.x = 23 * rank
	content.region_rect.position.y = 32 * suit


func on_select():
	
	if !is_selected and holder.selected.size() <= holder.max_selected - 1:
		is_selected = ! is_selected
	elif is_selected:
		is_selected = ! is_selected
	
	if is_selected:
		position.y = -20
		
		holder.add_selected(self)
		
	else:
		position.y = 0
		
		holder.remove_selected(self)


func randomize_card():
	suit = randi_range(0, CardData.Suit.size() - 1)
	rank = randi_range(0, CardData.Rank.size() - 1)


func set_card_visible(arg: bool):
	$Node/Base.visible = arg
	visible = arg


func set_sprite_position(position: Vector2):
	$Node/Base.position = position
