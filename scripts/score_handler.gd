extends Node

#TODO: read modifiers player has, pass into array
var modifiers_array: Array



var current_score: int:
    set(value):
        current_score = value
        points_added.emit(value)

#Signals
signal points_added(points)


func _ready() -> void:
    #var test_modifier = preload("res://scenes/packed_scenes/modifiers/test_modifier.tscn").instantiate()
    #add_child(test_modifier)
    #^this kind of malarkey will be happening in the shop or whatever, not here
    modifiers_array = get_tree().get_root().get_node("Main/Ship/CanvasLayer/UI_Modifiers").get_children()
    print(get_tree().get_root().get_node("Main/Ship/CanvasLayer/UI_Modifiers").get_children())
    pass


func apply_score(_merge_position:Vector2, merge_result_size:int):
    #print("apply_score called with merge_result_size = ", merge_result_size)
    var score_temp = merge_result_size
    for modifier in modifiers_array:
        score_temp =  modifier.calculate(score_temp)
    current_score += score_temp
    
