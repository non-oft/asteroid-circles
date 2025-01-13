extends Node

var current_score: int:
    set(value):
        points_added.emit(value)
        current_score = value

#Signals
signal points_added(points)

func _ready():
    pass

func _process(_delta: float) -> void:
    pass