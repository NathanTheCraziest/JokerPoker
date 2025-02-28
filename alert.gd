extends Control

class_name ScoreAlert

@onready var bg: ColorRect = $BG
@onready var label: Label = $Label
var time_since_last_active: float

func activate(new_pos: Vector2, text: String, on_bottom: bool = true):
	global_position = new_pos + Vector2(0, 80) if on_bottom else new_pos + Vector2(0, -80)
	time_since_last_active = 0
	visible = true
	animate_bg()
	label.text = text


func _process(delta: float) -> void:
	time_since_last_active += delta
	
	if time_since_last_active > 0.6:
		hide()


func _ready() -> void:
	Util.mult_alert = self


func animate_bg():
	var tween: Tween = create_tween()
	tween.tween_property(bg, "rotation", 50, 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(bg, "rotation", 45, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	
	var tween_size: Tween = create_tween()
	tween_size.tween_property(bg, "scale", Vector2(0.8, 0.8), 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween_size.tween_property(bg, "scale", Vector2(1, 1), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	
	var tween_text: Tween = create_tween()
	tween_text.tween_property(label, "position", Vector2(-45, -40), 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween_text.tween_property(label, "position", Vector2(-45, -45), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
