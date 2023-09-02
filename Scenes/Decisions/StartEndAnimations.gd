extends AnimationPlayer # Script for Running the Decision animations at start and end, for fading in/out

func playAnimation(animname: String, forward: bool) -> void:
	if forward:
		Globals.playerSpeed = 0
		$".".play(animname)
	else:
		Globals.playerSpeed = 550
		$".".play_backwards(animname)
