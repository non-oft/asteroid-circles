extends Node

#TODO: read modifiers player has, pass into array
var modifiers_array: Array


func _ready() -> void:
	var test_modifier = preload("res://scenes/packed_scenes/modifiers/test_modifier.tscn").instantiate()
	add_child(test_modifier)
	modifiers_array = [test_modifier]

var current_score: int:
	set(value):
		current_score = value
		points_added.emit(value)

#Signals
signal points_added(points)

func apply_score(_merge_position:Vector2, merge_result_size:int):
	print("apply_score called with merge_result_size = ", merge_result_size)
	for modifier in modifiers_array:
		print("should be merged circle size +1: ",modifier.calculate(merge_result_size))

		current_score += modifier.calculate(merge_result_size)
	

