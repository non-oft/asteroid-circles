extends Node2D

##Number of circles to be shot for this level
@export var level_circle_count := 10
##Range of circle sizes to be selected from for this level (0 to this)
@export var level_circle_range := 4
# TODO: hook these properly to level properties?
@export var circle:PackedScene
@export_group("Firing Parameters")
##Distance from center of ship model circles will be shot from
@export_range(0,300) var fire_distance:float = 35
@export var fire_velocity:float = 250
@onready var root_node = get_tree().get_root().get_node("Main")
@onready var ship = $".."
var circle_deck := {}
var shot_count := 0
var current_circle_size
@onready var ui_circle_feed = $"../CanvasLayer/UI_CircleFeed"

#starter deck: index is circle size, value is quantity
#eventually should be configurable, or at least selectable; for now, just hard-coded here
var starter_deck: Array = [10,10,10,8,6,4,2]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    
    firing_system_initialize()
    #for index in range(level_circle_count):
        #var random = randi_range(0,level_circle_range)
        #circle_deck.append(random)
    ui_circle_feed.ui_circle_feed_initialize(circle_deck)

func firing_system_initialize():
    var index_circle_size = 0
    var current_deck_index = 0
    for quantity in starter_deck:
        for this_circle in range(quantity):
            circle_deck[str(current_deck_index)] = {
                    "circle_size": index_circle_size,
                    "seal": 0,
                    "quality": 0,
                    "shininess": 1
                }
            
            
            current_deck_index += 1
        index_circle_size += 1
    print(circle_deck)
    print(circle_deck.size())
            



func on_shot_fired():
    # print("shot fired")
    if(shot_count<circle_deck.size()):
        
        var this_circle = circle.instantiate()
        root_node.add_child(this_circle)
        this_circle.position = ship.position + Vector2.from_angle(ship.rotation-(PI/2)) * fire_distance
        this_circle.linear_velocity = Vector2.from_angle(ship.rotation-(PI/2)) * fire_velocity
        current_circle_size = circle_deck[str(shot_count)]["circle_size"]
        this_circle.circle_size = current_circle_size


        shot_count += 1
        ui_circle_feed.ui_shot_count = shot_count
        #TODO ^not updating properly?

    else:
        print("out of shots")
