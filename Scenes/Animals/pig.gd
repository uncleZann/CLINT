extends CharacterBody2D

var speed = 100.0
var pigDirection = 1

func _ready():
	switch()
func _process(delta):
	if pigDirection == 0:
		velocity.x = move_toward(speed, 0.0, delta)
	else:
		velocity.x = move_toward(-speed, 0.0, delta)

	$Sprite2D.flip_h = velocity.x > 0
	$Sprite2D/modulate.flip_h = velocity.x > 0
	velocity.y += 500 * delta
	move_and_slide()

func _on_timer_timeout():
	switch()
func switch():
	pigDirection = randi_range(0, 1)
	$Timer.wait_time = randi_range(3, 15)
	$Timer.start()
