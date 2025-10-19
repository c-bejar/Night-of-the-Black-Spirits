extends CanvasLayer

func _ready() -> void:
	Globals.update_score.connect(update_score_text)
	update_score_text()

func update_score_text() -> void:
	%ScoreBox.text = str(Globals.current_score)
