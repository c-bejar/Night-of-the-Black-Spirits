extends StaticBody2D

const MAX_TIMER_CHECKS: int = 3

var total_checks: int = 0

func tv_destroyed() -> void:
	$GPUParticles2D.emitting = true
	$TV.hide()
	$PointLight2D.hide()
	await $GPUParticles2D.finished
	self.queue_free()


func _on_timer_check_timeout() -> void:
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("start_face")
	else:
		$AnimationPlayer.speed_scale *= 1.5
	if total_checks > MAX_TIMER_CHECKS:
		pass
	total_checks += 1
