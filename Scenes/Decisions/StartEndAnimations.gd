extends AnimationPlayer

func playAnimation(animname: String, forward: bool) -> void:
	if forward:
		Globals.playerSpeed = 0
		$".".play(animname)
	else:
		Globals.playerSpeed = 550
		$".".play_backwards(animname)
