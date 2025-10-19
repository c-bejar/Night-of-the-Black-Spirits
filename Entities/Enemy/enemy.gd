extends CharacterBody2D

const SPEED: int = 25

var health: int = 5
var currently_attacking: bool = false
var PlayerBody: CharacterBody2D = null

func _process(delta: float) -> void:
	if currently_attacking:
		if "hit" in PlayerBody:
			PlayerBody.hit()
		
	self.look_at(Globals.player_pos)
	
	var direction: Vector2 = (Globals.player_pos - self.global_position).normalized()
	var movement: Vector2 = direction * SPEED * delta
	
	var collision: KinematicCollision2D = self.move_and_collide(movement)

	if collision:
		pass


func hit() -> void:
	$HurtSound.play()
	$GPUParticles2D.material.set_shader_parameter("progress", 1)
	$ShaderTimer.start()
	health -= 1
	if health <= 0:
		Globals.current_score += 500
		self.queue_free()


func _on_shader_timer_timeout() -> void:
	$GPUParticles2D.material.set_shader_parameter("progress", 0)


func _on_attack_area_body_entered(body: Node2D) -> void:
	currently_attacking = true
	PlayerBody = body


func _on_attack_area_body_exited(_body: Node2D) -> void:
	currently_attacking = false
	PlayerBody = null
