extends PanelContainer

class_name Tip

@onready var label: RichTextLabel = $RichTextLabel
var current_card: CardInstance = null
var can_show: bool = true

func _ready() -> void:
	Util.tip = self

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("select"):
		can_show = false
	if Input.is_action_just_released("select"):
		can_show = true

func set_text(text: String, card: CardInstance):
	if can_show:
		show()
		current_card = card
		label.text = text
		label.size.y = label.get_minimum_size().y
		global_position = card.global_position + Vector2(-70, 70) if card.global_position.y <= 0 else card.global_position + Vector2(-70, -70 - size.y)
	

func try_hide(card: CardInstance):
	if card == current_card:
		hide()
