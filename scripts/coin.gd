extends Area2D

var soundPlayed = false

func _on_body_entered(body):
	if body.name == 'player':
		$anim.play("collect")
		if not soundPlayed:
			$audio.play()
			soundPlayed = true

func _on_anim_animation_finished():
		queue_free()
