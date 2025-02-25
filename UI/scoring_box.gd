extends HBoxContainer

class_name ScoringBox

@onready var chip_label: Label = $Chip/Label
@onready var mult_label: Label = $Mult/Label

var chips: float = 0
var mult: float = 0

func add_chips(amount: float):
	chips += amount
	chip_label.text = str(chips)
	
	var tween: Tween = create_tween()
	tween.tween_property(chip_label, "rotation_degrees", 10, 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(chip_label, "rotation_degrees", 0, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
