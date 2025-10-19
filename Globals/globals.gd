extends Node

signal update_score()

var current_score: int = 0:
	set(value):
		if value > 999_999_999:
			current_score = 999_999_999
		else:
			current_score = value
		update_score.emit()
var highest_score: int = 0
var spawns: Array = []
var player_pos: Vector2 = Vector2.ZERO
var timer_amount: float = 1.0

func _ready() -> void:
	var tween: PropertyTweener = self.create_tween().tween_property(self, "timer_amount", 0, 300)
	tween.set_trans(Tween.TRANS_CIRC)
