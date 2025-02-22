extends Node2D

class_name CardHolder

var cards: Array[CardInstance]
var hovering: Array[int]

var selected: Array[CardInstance]
@export var max_selected: int = 1

@onready var holder: Node2D = $Holder
@onready var min: Node2D = $Min
@onready var max: Node2D = $Max

signal on_hand_changed

func _ready() -> void:
	organize_cards()

func check_cards():
	
	cards.clear()
	
	for i in holder.get_children():
		if i is CardInstance:
			cards.append(i)
			i.holder = self

func organize_cards():
	
	check_cards()
	
	var distance: float = -min.position.x + max.position.x
	var space: float = distance / (cards.size() + 1)
	print(space)
	for i in cards.size():
		cards[i].position = Vector2(min.position.x + space * (i + 1), 0)

func _process(delta: float) -> void:
	pass

func add_hover(index: int):
	hovering.append(index)

func remove_hover(index: int):
	hovering.remove_at(hovering.find(index))

func reset_hover():
	hovering.clear()

func is_highest_hover(index: int):
	var is_high: bool = false
	var highest: int = 0
	
	for i in hovering:
		if highest < i:
			highest = i
	
	if highest == index:
		is_high = true
	
	
	return is_high

func add_selected(card: CardInstance):
	selected.append(card)
	on_hand_changed.emit()

func remove_selected(card: CardInstance):
	
	selected.remove_at(selected.find(card))
	on_hand_changed.emit()
