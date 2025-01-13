extends Label

var score_counter = ScoreHandler


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreHandler.points_added.connect(_on_score_change)


func _on_score_change(score):
	self.text = str(score)