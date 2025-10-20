extends CharacterBody2D

const SPEED: int = 25

var health: int = 5
var currently_attacking: bool = false
var can_be_hit: bool = true
var PlayerBody: CharacterBody2D = null
var enemy_alpha: float = 0:
	set(value):
		enemy_alpha = value
		update_alpha(enemy_alpha)

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
	if health > 0:
		$HurtSound.play()
		$GPUParticles2D.material.set_shader_parameter("progress", 1)
		$ShaderTimer.start()
		health -= 1
	if health <= 0 and can_be_hit:
		can_be_hit = false
		Globals.current_score += 500
		var tween : Tween= self.create_tween()
		tween.tween_property(self, "enemy_alpha", 1, 0.25)
		await tween.finished
		self.queue_free()

func update_alpha(value: float) -> void:
	$GPUParticles2D.material.set_shader_parameter("alpha", 0)
	$GPUParticles2D.material.set_shader_parameter("progress", value)


func _on_shader_timer_timeout() -> void:
	$GPUParticles2D.material.set_shader_parameter("progress", 0)


func _on_attack_area_body_entered(body: Node2D) -> void:
	currently_attacking = true
	PlayerBody = body


func _on_attack_area_body_exited(_body: Node2D) -> void:
	currently_attacking = false
	PlayerBody = null
