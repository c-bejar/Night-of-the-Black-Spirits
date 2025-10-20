extends CanvasLayer

func _ready() -> void:
	Globals.update_score.connect(update_score_text)
	Globals.update_health.connect(update_health_bar)
	Globals.game_has_ended.connect(end_game_process)
	update_score_text()
	update_health_bar()
	

func start_game() -> void:
	$GameUI.show()


func update_score_text(collected: bool = false) -> void:
	if collected:
		$Audio/ScoreUp.stop()
		$Audio/ScoreUp.play()
		var tween: Tween = self.create_tween()
		tween.tween_property(%HBoxContainer, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.15)
		tween.tween_property(%HBoxContainer, "modulate", Color(0.0, 0.784, 0.0, 1.0), 0.15)

	%ScoreBox.text = "%09d" % Globals.current_score
	
	
func update_health_bar(_damaged: bool = false) -> void:
	%ProgressBar.value = Globals.player_health
	

func end_game_process() -> void:
	$GameUI.hide()
	$EndUI.show()
	%FinalScoreBox.text = "%09d" % Globals.current_score
	$Audio/EndAudio.volume_db = 0


func _on_start_button_pressed() -> void:
	self.get_tree().change_scene_to_file("res://Areas/House/house.tscn")
	$StartUI.hide()
	$GameUI.show()
	$Audio/MenuAudio.volume_db = -80


func _on_controls_button_pressed() -> void:
	$StartUI/ControlsPopup.show()


func _on_controls_exit_button_pressed() -> void:
	$StartUI/ControlsPopup.hide()
