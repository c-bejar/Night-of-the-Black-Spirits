extends CanvasLayer

func _ready() -> void:
	Globals.update_score.connect(update_score_text)
	Globals.update_health.connect(update_health_bar)
	update_score_text()
	update_health_bar()

func update_score_text(collected: bool = false) -> void:
	if collected:
		$Audio/ScoreUp.stop()
		$Audio/ScoreUp.play()
		var tween: Tween = self.create_tween()
		tween.tween_property(%HBoxContainer, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.15)
		tween.tween_property(%HBoxContainer, "modulate", Color(0.0, 0.784, 0.0, 1.0), 0.15)

	%ScoreBox.text = "%09d" % Globals.current_score
func update_health_bar(_damaged: bool = false) -> void:
	#if damaged:
		#var tween: Tween = self.create_tween()
		#tween.tween_property(%ProgressBar, "bg_color", Color(0.608, 0.0, 0.0, 1.0), 0.15)
		#tween.tween_property(%ProgressBar, "bg_color", Color(0.196, 0.549, 0.196, 1.0), 0.15)
	%ProgressBar.value = Globals.player_health
	
