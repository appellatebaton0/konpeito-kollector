@tool
class_name VelocityField extends Polygon2D

@export var velocity := Vector2.ZERO:
	set(to):
		
		velocity = to
		
		upd_material()

func upd_material() -> void:
	if material:
		(material as ShaderMaterial).set_shader_parameter("velocity", velocity)

var _area :Area2D

func _ready() -> void:
	
	if not material:
		material = ShaderMaterial.new()
		material.shader = preload("res://Wind.gdshader")
		material.set_shader_parameter("noise", preload("res://Assets/Textures/Noise.tres"))
		texture = preload("res://Assets/Textures/White.tres")
	
	color = Color.html("#d9d4d8d2")
	
	if Engine.is_editor_hint(): return
	
	_area = Area2D.new()
	
	
	
	add_child(_area)
	
	var shape = CollisionPolygon2D.new()
	shape.polygon = polygon
	
	_area.add_child(shape)

func _physics_process(_delta: float) -> void:
	
	if not _area: return
	
	for body in _area.get_overlapping_bodies():
		if body is Soot:
			body.velocity += velocity
