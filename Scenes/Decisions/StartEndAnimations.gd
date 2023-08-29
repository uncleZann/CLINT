extends AnimationPlayer


func playAnimation(name: String, forward: bool) -> void:
	if forward:
		Globals.playerSpeed = 0
		$".".play(name)
	else:
		Globals.playerSpeed = 550
		$".".play_backwards(name)
