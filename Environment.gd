class_name Ground extends Polygon2D
## An environment polygon that makes its own collision.

var _staticbody :StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	## Smooth out the corners of the polygon.
	
	var new_gon :PackedVector2Array
	
	for i in polygon.size():
		
		var last := polygon[wrapi(i - 1, 0, polygon.size())]
		var curr := polygon[i]
		var next := polygon[wrapi(i + 1, 0, polygon.size())]
		
		var a = curr + (curr.direction_to(last) * 10.0)
		var c = curr + (curr.direction_to(next) * 10.0)
		var b = lerp(curr, lerp(a, c, 0.5), 0.5)
		
		new_gon.append(a)
		new_gon.append(b)
		new_gon.append(c)
	
	polygon = new_gon
	
	## Make the collider.
	
	_staticbody = StaticBody2D.new()
	
	var collider := CollisionPolygon2D.new()
	
	collider.polygon = polygon
	
	add_child(_staticbody)
	
	_staticbody.add_child(collider)
