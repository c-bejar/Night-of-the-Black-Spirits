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
		$TimerCheck.stop()
		$GPUParticles2D.one_shot = false
		$GPUParticles2D.emitting = true
		await self.get_tree().create_timer(1).timeout
		var EnemyScene: PackedScene = preload("res://Entities/Enemy/enemy.tscn")
		var Enemy: CharacterBody2D = EnemyScene.instantiate()
		Enemy.global_position = self.global_position
		self.get_tree().get_root().add_child(Enemy)
		self.queue_free()
	total_checks += 1
