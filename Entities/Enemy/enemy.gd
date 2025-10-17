extends CharacterBody2D

const SPEED: int = 25

func _process(delta: float) -> void:
	self.look_at(Globals.player_pos)
	
	var direction: Vector2 = (Globals.player_pos - self.global_position).normalized()
	var movement: Vector2 = direction * SPEED * delta
	
	var collision: KinematicCollision2D = self.move_and_collide(movement)

	if collision:
		pass
