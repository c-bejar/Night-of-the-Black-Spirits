extends CharacterBody2D

const SPEED: int = 25

var health: int = 5

func _process(delta: float) -> void:
	self.look_at(Globals.player_pos)
	
	var direction: Vector2 = (Globals.player_pos - self.global_position).normalized()
	var movement: Vector2 = direction * SPEED * delta
	
	var collision: KinematicCollision2D = self.move_and_collide(movement)

	if collision:
		pass


func hit() -> void:
	$GPUParticles2D.material.set_shader_parameter("progress", 1)
	$ShaderTimer.start()
	health -= 1
	if health <= 0:
		self.queue_free()


func _on_shader_timer_timeout() -> void:
	$GPUParticles2D.material.set_shader_parameter("progress", 0)
