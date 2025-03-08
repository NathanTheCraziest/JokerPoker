extends Node2D

class_name CardHolder

var cards: Array[CardInstance]
var hovering: Array[CardInstance]

var selected: Array[CardInstance]
@export var max_selected: int = 1
@export var hide_position: Vector2
@export var show_position: Vector2
@export var is_hidden: bool = false
var container_size: int = 10

@onready var holder: Node2D = $Holder
@onready var min: Node2D = $Min
@onready var max: Node2D = $Max

signal on_hand_changed

func _ready() -> void:
	check_cards()
	organize_cards()

func check_cards():
	
	cards.clear()
	
	for i in holder.get_children():
		if i is CardInstance:
			cards.append(i)
			i.holder = self

func organize_cards():
	
	var distance: float = -min.position.x + max.position.x
	var space: float = distance / (cards.size() + 1)
	for i in cards.size():
		cards[i].position = Vector2(min.position.x + space * (i + 1), 0 if cards[i].is_selected else 25)
		cards[i].update_draw_order()
		

func _process(delta: float) -> void:
	pass

func add_hover(index: CardInstance):
	hovering.append(index)

func remove_hover(index: CardInstance):
	hovering.remove_at(hovering.find(index))

func reset_hover():
	hovering.clear()

func is_highest_hover(index: CardInstance):
	var is_high: bool = false
	var highest: int = 0
	
	for i in hovering:
		if i != null:
			if highest < i.get_index():
				highest = i.get_index()
	
	if highest == index.get_index():
		is_high = true
	
	
	return is_high

func add_selected(card: CardInstance):
	selected.append(card)
	on_hand_changed.emit()

func remove_selected(card: CardInstance):
	
	selected.remove_at(selected.find(card))
	on_hand_changed.emit()

func space_between_cards():
	var distance: float = -min.position.x + max.position.x
	return distance / cards.size()

func delete_card(card: CardInstance):
	var selected_card: CardInstance = cards[cards.find(card)]
	cards.remove_at(cards.find(card))
	remove_selected(selected_card)
	
	card.queue_free()
	organize_cards()

func set_holder_hidden(arg: bool):
	is_hidden = arg
	
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", show_position if !is_hidden else hide_position, 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
