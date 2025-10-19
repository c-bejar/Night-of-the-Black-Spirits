extends Node

signal update_score(collected: bool)
signal update_health(damaged: bool)

var current_score: int = 0:
	set(value):
		if value > 999_999_999:
			current_score = 999_999_999
		else:
			current_score = value
		update_score.emit(true)
var highest_score: int = 0
var spawns: Array = []
var player_pos: Vector2 = Vector2.ZERO
var player_health: int = 10:
	set(value):
		player_health = value
		update_health.emit(true)
		
var timer_amount: float = 1.0

func _ready() -> void:
	var tween: Tween = self.create_tween()
	tween.tween_property(self, "timer_amount", 0, 300)
	tween.set_trans(Tween.TRANS_CIRC)
