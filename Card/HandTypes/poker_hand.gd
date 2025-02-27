extends Node

class_name PokerHand

var hand_name: String = "High Card"

var level: int = 0
var chips: float = 10.0
var mult: float = 2.0


func _init(_hand_name: String, _chips: float, _mult: float) -> void:
	hand_name = _hand_name
	chips = _chips
	mult = _mult
