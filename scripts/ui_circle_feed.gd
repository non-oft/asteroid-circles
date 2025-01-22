extends VBoxContainer

@export var preview_number = 6
var circle_deck
@export var circle:PackedScene

var ui_shot_count = 0:
    set(value):
        var shot_count = value
        for child in get_children():
            if circle_deck.size() > shot_count+child.circle_index:
                child.circle_size = circle_deck[str(shot_count+child.circle_index)]["circle_size"]
            else:
                child.circle_size = -1


func ui_circle_feed_initialize(circle_deck_input:Dictionary) -> void:
    
    circle_deck = circle_deck_input
    if circle:
        for index in range(preview_number):
            var this_circle = circle.instantiate()
            self.add_child(this_circle)
            this_circle.circle_index = index
            print("added child ", this_circle, " with index ", this_circle.circle_index, " to ", this_circle.get_parent().name)
            
    else:
        print("missing circle_ui PackedScene")
    
    #increment_circles_animation_start()
    for child in get_children():
        child.circle_ui_initialize()
        if circle_deck.size() > child.circle_index:
            child.circle_size = circle_deck[str(child.circle_index)]["circle_size"]
        else:
            child.circle_size = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass
