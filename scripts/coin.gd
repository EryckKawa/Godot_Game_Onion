extends Area2D

var coins := 1
var soundPlayed = false

func _on_body_entered(body):
	if body.name == 'player':
		$anim.play("collect")
		#Era pra evitar a colisão dupla de moedas
		#Arruma depois
		#await $collision.call_deferred("queue_free")
		if not soundPlayed:
			$audio.play()
			soundPlayed = true
	Globals.coins += coins
func _on_anim_animation_finished():
	queue_free()
