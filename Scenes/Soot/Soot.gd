class_name Soot extends CharacterBody2D
## The 'player', a soot sprite boyo.

@export_group("Cast", "cast")
@export var cast_range := 150.0
@export var cast_count := 40
@export var cast_force := 1800
@export var cast_exponential := 1.4
@export var gravity := 0.5

@onready var casts :Array[RayCast2D]

func _ready() -> void:
	
	for i in cast_count:
		var angle := TAU * (i / float(cast_count))
		
		var new := RayCast2D.new()
		
		add_child(new)
		
		new.target_position = Vector2.from_angle(angle) * cast_range
		
		casts.append(new)
	
	velocity = Vector2.ONE * 50.0

func _physics_process(_delta: float) -> void:
	
	for cast in casts:
		
		if not cast.is_colliding(): continue
		
		var point := cast.get_collision_point()
		
		var dir := point.direction_to(global_position)
		
		var force := (cast_range - (global_position.distance_to(point))) ** cast_exponential
		#print(force)
		
		velocity += dir * force / cast_force
	
	velocity += Vector2.DOWN * gravity
	
	$Sprite.rotate(velocity.distance_to(Vector2.ZERO) * 0.0003 * signf(velocity.x))
	
	$Wind.volume_linear = clampf(velocity.distance_to(Vector2.ZERO) / 450.0, 0.0, 1.0)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("Up"):
		
		var dir := velocity.normalized()
		
		if velocity.distance_to(Vector2.ZERO) > 450.0:
			return
		
		velocity += dir * 10.0
		
	elif event.is_action_pressed("Down"):
		
		if velocity.distance_to(Vector2.ZERO) < 30.0:
			return
		
		velocity /= 1.05

#func _draw() -> void:
	#
	#for cast in casts:
		#
		#if not cast.is_colliding(): 
			#
			#draw_circle(cast.target_position, 2.0, Color.BLUE)
			#
			#continue
		#
		#var point := cast.get_collision_point()
		#
		#draw_circle(point - position, 2.0, Color.RED)

	
