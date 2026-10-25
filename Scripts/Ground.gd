@tool
class_name Ground extends Polygon2D
## An environment polygon that makes its own collision.

var _staticbody :StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	texture = preload("res://Ground.png")
	texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	
	if Engine.is_editor_hint(): return
	
	z_index = 3
	
	## Smooth out the corners of the polygon.
	
	polygon = round_polygon(polygon)
	
	## Make the collider.
	
	_staticbody = StaticBody2D.new()
	
	var collider := CollisionPolygon2D.new()
	
	collider.polygon = polygon
	
	add_child(_staticbody)
	
	_staticbody.add_child(collider)

static func round_polygon(gon :PackedVector2Array, amount := 10.0) -> PackedVector2Array:
	var new_gon :PackedVector2Array
	
	for i in gon.size():
		
		var last := gon[wrapi(i - 1, 0, gon.size())]
		var curr := gon[i]
		var next := gon[wrapi(i + 1, 0, gon.size())]
		
		var a = curr + (curr.direction_to(last) * amount)
		var c = curr + (curr.direction_to(next) * amount)
		var b = lerp(curr, lerp(a, c, 0.5), 0.6)
		
		new_gon.append(a)
		new_gon.append(b)
		new_gon.append(c)
	
	return new_gon
