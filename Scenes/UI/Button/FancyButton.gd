class_name FancyButton extends Button

@onready var effect :AnimatedPolygon = $Effect
@onready var konpeito :AnimatedPolygon = $Konpeito

var tween :Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_selected)
	mouse_exited.connect(_deselected)
	focus_entered.connect(_selected)
	focus_exited.connect(_deselected)
	
	pressed.connect(HUD.play_click_sfx)
	
	_deselected()

func _selected() -> void:
	effect.processing = true
	konpeito.processing = true
func _deselected() -> void:
	effect.processing = false
	konpeito.processing = false

func _pressed() -> void:
	
	if tween and tween.is_running():
		tween.kill()
	
	effect.scale = Vector2.ONE
	effect.self_modulate.a = 1.0
	
	tween = create_tween().set_ease(Tween.EASE_OUT).set_parallel()
	
	tween.tween_property(effect, "scale", Vector2.ONE * 1.7, 0.5)
	tween.tween_property(effect, "self_modulate:a", 0.0, 0.5)
	
	
