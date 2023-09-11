extends base_item

# Resources ------------ Resources ------------ Resources ------------ Resources ------------ Resources
@export var theResource: Resource

func _ready():
	$Sprite2D.texture = theResource.spriteTexture
# Resources ------------ Resources ------------ Resources ------------ Resources ------------ Resources

#func pickupItem():
#	pass
