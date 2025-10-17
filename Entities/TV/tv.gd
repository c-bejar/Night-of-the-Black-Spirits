extends StaticBody2D

func tv_destroyed() -> void:
	$GPUParticles2D.emitting = true
	$TV.hide()
	$PointLight2D.hide()
	await $GPUParticles2D.finished
	self.queue_free()
