extends CanvasLayer
## The global transition manager.

@onready var anim_player := $AnimationPlayer

func transition(to :PackedScene) -> void:
	anim_player.play("Transition")
	
	await anim_player.animation_finished
	
	print("transition to ", to)
	get_tree().change_scene_to_packed(to)
	
	anim_player.play("Transition", -1, -1, true)
	
