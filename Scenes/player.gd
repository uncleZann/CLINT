extends CharacterBody2D
class_name Player

#player movement
var speed: int = 750
var jumpVelocity: int = -840
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var looking = true
@onready var mark = $Pivot
@onready var animationPlayer = $AnimationPlayer
@onready var rightHand = $Pivot/RightHand
@onready var leftHand = $Pivot/LeftHand

var zommedAmmount = 0.5
#player movement

#escape
signal escapePressed
#escape

func _ready():
	Globals.connect("playerSpeedChange", playerSpeedChange)
func playerSpeedChange():
	speed = Globals.playerSpeed

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	
	if animationPlayer.current_animation == "falling":
		await get_tree().create_timer(0.2).timeout
		velocity.y += gravity * delta
	#gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	#jump
	if Input.is_action_pressed("jump") and is_on_floor():
		#animationPlayer.play("Jump")
		#await get_tree().create_timer(0.1).timeout
		velocity.y = jumpVelocity
	
#	if Input.is_action_pressed("zoomout"):
#		if zommedAmmount >= 0.01:
#			zommedAmmount += -0.01
#	elif Input.is_action_pressed("zoomin"):
#		zommedAmmount += 0.01
		
	$playerCamera.zoom = Vector2(zommedAmmount, zommedAmmount)

	var direction = Input.get_axis("left", "right")
	#if input v   -  direction is eaither left or right
	
	if direction:
		animationPlayer.play("Walk")
		velocity.x = direction * speed
		
		
	else:
		#if not pressing -> stop moving
		velocity.x = move_toward(velocity.x, 0, speed)
		if animationPlayer.is_playing():
			animationPlayer.stop()
		
	move_and_slide()

	#Changing the facing direction:
	var player_direction = (get_global_mouse_position() - position).normalized()
	var raddeg = rad_to_deg(player_direction.angle() + 500)

	if player_direction.x < 0 and looking == true:
		mark.scale.x = -1
		rightHand.scale.x = -0.15; leftHand.scale.x = -0.15
		looking = false
	if player_direction.x > 0 and looking == false:
		mark.scale.x = 1
		rightHand.scale.x = 0.15; leftHand.scale.x = 0.15
		looking = true
	
	if player_direction.x > 0:
		raddeg = rad_to_deg(player_direction.angle())
		raddeg -= 30
	else:
		raddeg = -rad_to_deg(player_direction.angle())
		raddeg += 15
	
	
	leftHand.rotation_degrees = raddeg
	rightHand.rotation_degrees = raddeg
