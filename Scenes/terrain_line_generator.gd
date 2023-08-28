extends Line2D

var displacement
var iterations
var height
var smooth

var current_displacement

#how low and how high can the lowest and higest point be
var lowHighPoint = 200000

#portal
var end
var start
#portal

var rng = RandomNumberGenerator.new()
func random_numGen():
	var randomDisplacment = rng.randi_range(15000, 25000)
	var randomHeight = rng.randi_range(15000, 25000)
	var randomItterations = rng.randf_range(10.0, 12.0)
	var randomSmoothness = rng.randf_range(0.8, 1.0)
	
	displacement = randomDisplacment
	iterations = randomItterations
	height = randomHeight
	smooth = randomSmoothness
	
var screensize

func _ready():
	random_numGen()
	randomize()
	init_line()
	
func init_line():
	
	var randomColor = Color(rng.randf(), rng.randf(), rng.randf(), 1.0)
	$Polygon2D.color = randomColor
	$".".material.set_shader_parameter("modulateColor", randomColor)
	
	current_displacement = displacement
	screensize = Vector2(200000, lowHighPoint)
	points = PackedVector2Array()
	start = Vector2(0, randi_range(height-displacement,
								height+displacement))
	end = Vector2(screensize.x, randi_range(height-displacement,
								height+displacement))
	add_point(start)
	add_point(end)
	
	for i in range(iterations):
		add_points()

	
	var p1 = points
	p1.append(Vector2(screensize.x, screensize.y))
	p1.append(Vector2(0, screensize.y))
	$StaticBody2D/CollisionPolygon2D.polygon = p1
	
	var p = points
	p.append(Vector2(screensize.x, screensize.y))
	p.append(Vector2(0, screensize.y))
	$Polygon2D.polygon = p
	
	spawn_portal()
	spawn_items()
	#ocean()
	
func add_points():
	var old_points = points
	points = PackedVector2Array()
	for i in range(old_points.size() - 1):
		var midpoint = (old_points[i] + old_points[i+1]) / 2
		midpoint.y += current_displacement * pow(-1.0, randi() % 2)
		add_point(old_points[i])
		add_point(midpoint)
	add_point(old_points[old_points.size() - 1])
	current_displacement *= pow(2.0, -smooth)

func spawn_portal():
	var portalInst = preload("res://Scenes/portal.tscn")
	
	var portal = portalInst.instantiate()
	portal.position = end
	self.add_child(portal)
	
	$"../../Player".position = start + Vector2(1500, -3000)

func spawn_items():
	var allOfThem = points
	var itemInst = preload("res://Scenes/story_detectors.tscn")
	var usedPoints = []
	
	for i in 38:
		
		var selected_point = rng.randi_range(1, allOfThem.size())#50, allOfThem.size())
		if not selected_point in usedPoints:
			var item = itemInst.instantiate()
			item.position = allOfThem[selected_point]
			self.add_child(item)
			
			#talk to clint
	#1. calls out signal - connects it - gets node foreground, from root -> takes its function and connects it
			item.storyDetected.connect(owner.get_node("Foreground")._on_story_detectors_story_detected)
			usedPoints.append(selected_point)
			for f in 25:
				usedPoints.append(selected_point + f)
				usedPoints.append(selected_point - f)

#func ocean(): # Draws oceans
#	var allOfThem = points
#	var usedPoints = []
#	print(allOfThem.size())
#	var itemInst = preload("res://Scenes/water_polygon.tscn")
#	var oceans = 0
#	for i in 100:
#		var num2
#		var e = []
#		var selected_point = rng.randi_range(10, allOfThem.size())
#		if not selected_point in usedPoints:
#			for num in 100:
#				num2 = num
#				if selected_point + num < allOfThem.size():
#					if allOfThem[selected_point].y < allOfThem[selected_point + num2].y:
#						e.append(allOfThem[selected_point + num2])
#					else:
#						if e.size() > 4:
#							var item = itemInst.instantiate()
#							#item.position = pointNumberOne
#							self.add_child(item)
#							item.polygon = e
#							var kids = item.get_children()[0].get_children()[0]
#
#							usedPoints.append(e)
#							break
