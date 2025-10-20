extends CanvasLayer

signal game_restarted()

var new_high_score: bool = false
@onready var HighScoreDisplay: HBoxContainer = $EndUI/ScoreDisplay/VBoxContainer/HBoxContainer

func _ready() -> void:
	Globals.update_score.connect(update_score_text)
	Globals.update_health.connect(update_health_bar)
	Globals.game_has_ended.connect(end_game_process)
	Globals.new_high_score.connect(set_high_score_color)
	update_score_text()
	update_health_bar()
	

func start_game() -> void:
	$GameUI.show()


func update_score_text(collected: bool = false) -> void:
	if collected and $GameUI.visible:
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
	if new_high_score:
		HighScoreDisplay.modulate = Color(1.0, 1.0, 0.369, 1.0)
	else:
		HighScoreDisplay.modulate = Color(1.0, 1.0, 1.0, 1.0)
	Globals.highest_score = Globals.current_score
	%FinalScoreBox.text = "%09d" % Globals.current_score
	%HighScoreBox.text = "%09d" % Globals.highest_score
	$Audio/EndAudio.volume_db = 0

func set_high_score_color() -> void:
	new_high_score = true

func _on_start_button_pressed() -> void:
	self.get_tree().change_scene_to_file("res://Areas/House/house.tscn")
	$StartUI.hide()
	$GameUI.show()
	$Audio/MenuAudio.volume_db = -80


func _on_controls_button_pressed() -> void:
	$StartUI/ControlsPopup.show()


func _on_controls_exit_button_pressed() -> void:
	$StartUI/ControlsPopup.hide()


func _on_restart_button_pressed() -> void:
	$Audio/EndAudio.volume_db = -80
	Globals.current_score = 0
	Globals.player_health = 10
	$EndUI.hide()
	$GameUI.show()
	new_high_score = false
	Globals.game_ended = false
	Globals.timer_amount = Globals.INITIAL_TIMER_AMOUNT
	game_restarted.emit()
