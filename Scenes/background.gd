extends CanvasLayer

func _ready():
	var allOfThem = $AllOfThem.get_children()
	var selected_wallpaper = allOfThem[randi() % allOfThem.size()] 
	selected_wallpaper.visible = true	

func _process(_delta):
	$Control/FpsCounter.text = str(Engine.get_frames_per_second())
