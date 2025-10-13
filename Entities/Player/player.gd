extends CharacterBody2D

const SPEED: int = 75

var speed_modifier: float = 1.0
var last_facing_direction: Vector2 = Vector2.DOWN

func _process(_delta: float) -> void:
	var idle: bool = not self.velocity
	if not idle:
		last_facing_direction = self.velocity.normalized()
	
	set_animation_mode(last_facing_direction)
	
	var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction_vector: Vector2 = input_vector.normalized()
	self.velocity = direction_vector * SPEED * speed_modifier
	self.move_and_slide()
	
	$"Rotation Point".look_at(self.get_global_mouse_position())

func set_animation_mode(direction: Vector2) -> void:
	$AnimationTree.set("parameters/Idle/blend_position", direction)
	$AnimationTree.set("parameters/Move/blend_position", direction)
	
