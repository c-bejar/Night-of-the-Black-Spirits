extends Node

signal update_score(collected: bool)
signal update_health(damaged: bool)
signal game_has_ended()
signal new_high_score()

var current_score: int = 0:
	set(value):
		if value > 999_999_999:
			current_score = 999_999_999
		else:
			current_score = value
		update_score.emit(true)
var highest_score: int = 0:
	set(value):
		if value > highest_score:
			highest_score = value
			new_high_score.emit()
var spawns: Array = []
var player_pos: Vector2 = Vector2.ZERO
var player_health: int = 10:
	set(value):
		player_health = value
		update_health.emit(true)
		
const INITIAL_TIMER_AMOUNT: float = 8.0
var timer_amount: float = INITIAL_TIMER_AMOUNT
var game_ended: bool = false

func _ready() -> void:
	tween_timer()

func tween_timer() -> void:
	var tween: Tween = self.create_tween()
	tween.tween_property(self, "timer_amount", 0, 300).from(INITIAL_TIMER_AMOUNT)
	tween.set_trans(Tween.TRANS_CIRC)

func end_game() -> void:
	game_has_ended.emit()
