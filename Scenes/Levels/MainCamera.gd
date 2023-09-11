extends Camera2D #For camera movment

var TargetZoom: float = 1.0
const MinimumZoom: float = 0.5
const MaxZoom: float = 2.8
const ZoomIncrement: float = 0.1
const ZoomRate: float = 10

var speed = 550

func _process(delta):
			# Camera WASD Movment
	if Input.is_action_pressed("control"):
		speed = 750
	else:
		speed = 550
	var directionx = Input.get_axis("left", "right")
	var directiony = Input.get_axis("up", "down")
	if directionx:
		position.x += directionx * speed * delta
	if directiony:
		position.y += directiony * speed * delta
	# /Camera WASD Movment/

func _physics_process(delta) -> void:
	zoom = lerp(zoom, TargetZoom * Vector2.ONE, ZoomRate * delta)
	set_physics_process(not is_equal_approx(zoom.x, TargetZoom))
	
	Globals.cameraPosition = position

func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
				position -= (event.relative / zoom) * 0.5
	
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_out()
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_in()

func zoom_in() -> void:
	TargetZoom = clamp(TargetZoom - ZoomIncrement, MinimumZoom, MaxZoom)
	set_physics_process(true)

func zoom_out() -> void:
	TargetZoom = clamp(TargetZoom + ZoomIncrement, MinimumZoom, MaxZoom)
	set_physics_process(true)
