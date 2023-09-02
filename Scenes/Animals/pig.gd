extends CharacterBody2D

var speed = 100.0 #Pig speed
var pigDirection = 1 # Where the pig is facing

# Calls switch() on initialization
func _ready():
	switch()

# Animal Movement
func _process(delta):
	if pigDirection == 0:
		velocity.x = move_toward(speed, 0.0, delta)
	else:
		velocity.x = move_toward(-speed, 0.0, delta)

	$Sprite2D.flip_h = velocity.x > 0
	$Sprite2D/modulate.flip_h = velocity.x > 0
	velocity.y += 500 * delta
	move_and_slide()

# Detects the Timer timeout
func _on_timer_timeout() -> void:
	switch()

# The Switching of random directions
func switch() -> void:
	pigDirection = randi_range(0, 1)
	$Timer.wait_time = randi_range(3, 15)
	$Timer.start()
