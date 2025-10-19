extends StaticBody2D

signal tv_died()

const MAX_TIMER_CHECKS: int = 3

var total_checks: int = 0
var can_spawn_enemy: bool = true

func _ready() -> void:
	for i: int in range(1, 6):
		var timer: SceneTreeTimer = self.get_tree().create_timer(Globals.timer_amount * i)
		timer.timeout.connect(_on_timer_check_timeout)

func tv_destroyed(destroyed_by_player: bool = false) -> void:
	if destroyed_by_player:
		can_spawn_enemy = false
		Globals.current_score += 200
	$SmashSound.play()
	$GPUParticles2D.emitting = true
	$TV.hide()
	$CollisionShape2D.set_deferred("disabled", true)
	$PointLight2D.hide()
	await $GPUParticles2D.finished
	tv_died.emit()
	self.queue_free()


func _on_timer_check_timeout() -> void:
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("start_face")
	else:
		$AnimationPlayer.speed_scale *= 1.5
	if total_checks > MAX_TIMER_CHECKS:
		$GPUParticles2D.one_shot = false
		$GPUParticles2D.emitting = true
		await self.get_tree().create_timer(1).timeout
		
		if can_spawn_enemy:
			var EnemyScene: PackedScene = preload("res://Entities/Enemy/enemy.tscn")
			var Enemy: CharacterBody2D = EnemyScene.instantiate()
			Enemy.global_position = self.global_position
			self.get_tree().get_root().add_child(Enemy)
		
		tv_died.emit()
		Globals.spawns.erase(self.global_position)
		self.queue_free()
	total_checks += 1
