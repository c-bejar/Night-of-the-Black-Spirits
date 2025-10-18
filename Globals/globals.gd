extends Node

var spawns: Array = []
var player_pos: Vector2 = Vector2.ZERO
var timer_amount: float = 10.0

func _ready() -> void:
	var tween: PropertyTweener = self.create_tween().tween_property(self, "timer_amount", 0, 300)
	tween.set_trans(Tween.TRANS_CIRC)
