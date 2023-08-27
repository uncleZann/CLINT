extends Polygon2D


func _on_area_2d_body_entered(body):
	print("touching")
	body.global_position += Vector2(0, 100) * 10
