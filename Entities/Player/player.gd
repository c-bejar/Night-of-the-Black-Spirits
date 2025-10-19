extends CharacterBody2D

signal axe_attack()
signal tv_entered(body: Node2D)
signal tv_exited(body: Node2D)

const SPEED: int = 75

var can_be_damaged: bool = true
var speed_modifier: float = 1.0
var last_facing_direction: Vector2 = Vector2.DOWN

func _process(_delta: float) -> void:
	Globals.player_pos = self.global_position
	
	var idle: bool = not self.velocity
	if not idle:
		last_facing_direction = self.velocity.normalized()
	
	set_animation_mode(last_facing_direction)
	
	var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction_vector: Vector2 = input_vector.normalized()
	self.velocity = direction_vector * SPEED * speed_modifier
	self.move_and_slide()
	
	$"Rotation Point".look_at(self.get_global_mouse_position())
	if Input.is_action_just_pressed("attack"):
		attack()


func set_animation_mode(direction: Vector2) -> void:
	$AnimationTree.set("parameters/Idle/blend_position", direction)
	$AnimationTree.set("parameters/Move/blend_position", direction)


func attack() -> void:
	$AttackTimer.start()
	var tween: Tween = create_tween()
	tween.tween_property($"Rotation Point/AnimationRotation", "rotation", deg_to_rad(-100), 0.15)
	tween.tween_property($"Rotation Point/AnimationRotation", "rotation", deg_to_rad(100), 0.05)
	tween.tween_property($"Rotation Point/AnimationRotation", "rotation", deg_to_rad(0), 0.25)

func hit() -> void:
	if can_be_damaged:
		$HurtSound.play()
		can_be_damaged = false
		Globals.player_health -= 1
		$Sprite2D.material.set_shader_parameter("progress", 1)
		$ShaderTimer.start()
		$DamageCooldown.start()
	if Globals.player_health <= 0:
		pass

func _on_tv_detection_body_entered(body: Node2D) -> void:
	tv_entered.emit(body)


func _on_tv_detection_body_exited(body: Node2D) -> void:
	tv_exited.emit(body)


func _on_attack_timer_timeout() -> void:
	axe_attack.emit()
	$AxeSound.play()


func _on_damage_cooldown_timeout() -> void:
	can_be_damaged = true


func _on_shader_timer_timeout() -> void:
	$Sprite2D.material.set_shader_parameter("progress", 0)
