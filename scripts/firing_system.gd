extends Node2D

@export var circle:PackedScene
@export_group("Firing Parameters")
##Distance from center of ship model circles will be shot from
@export_range(0,300) var fire_distance:float = 35
@export var fire_velocity:float = 250

@onready var root_node = get_tree().get_root().get_node("Main")
@onready var ship = $".."
@onready var ui_circle_feed = $"../CanvasLayer/UI_CircleFeed"
@onready var level_counter = $"../CanvasLayer/LevelCounter"


var circle_deck : Array = []
var shot_count := 0
var current_circle_size
var out_of_shots: bool = false

var player_level: int = 0:
    set(value):
        player_level = value
        level_counter.text = str(player_level)

#starter deck: index is circle size, value is quantity
#eventually should be configurable, or at least selectable; for now, just hard-coded here
var starter_deck_basic: Array = [10,10,10,8,6,4,2]
var starter_deck_small: Array = [3,3,2,2]

#for now, manually change out this variable to use different decks; 'current_starter_deck' is what is used
var current_starter_deck = starter_deck_basic



# Kicks off the circle deck, firing system, and circle feed ui initialization
func _ready() -> void:
    firing_system_initialize()
    #circle_deck_shuffle()
    circle_deck.shuffle()
    current_circle_size = circle_deck[shot_count]["circle_size"]
    ui_circle_feed.ui_circle_feed_initialize(circle_deck)


func firing_system_initialize():
    var index_circle_size = 0
    #var current_deck_index = 0
    for quantity in current_starter_deck:
        for this_circle in range(quantity):
            circle_deck.append( {
                    "circle_size": index_circle_size,
                    "seal": 0,
                    "quality": 0,
                    "shininess": 1
                })
            #current_deck_index += 1
        index_circle_size += 1
    player_level = 0
            



#function that shuffles the deck into a random order (unused)
func circle_deck_shuffle():
    var circle_deck_temp = {}
    var current_index = 0
    var shuffled_keys = range(circle_deck.size)
    shuffled_keys.shuffle()
    for shuffled_index in shuffled_keys:
        circle_deck_temp[current_index] = circle_deck[shuffled_index]
        current_index += 1
    circle_deck = circle_deck_temp



#function to shuffle and reset deck
func circle_deck_reload():
    out_of_shots = false
    #circle_deck_shuffle()
    circle_deck.shuffle()
    ui_circle_feed.circle_deck = circle_deck
    ui_circle_feed.ui_shot_count = 0
    shot_count = 0



#function to fire circles, called when player_ship detects player input to fire a shot
func on_shot_fired():
    if(shot_count<circle_deck.size()):
        
        var this_circle = circle.instantiate()
        root_node.add_child(this_circle)
        this_circle.position = ship.position + Vector2.from_angle(ship.rotation-(PI/2)) * fire_distance
        this_circle.linear_velocity = Vector2.from_angle(ship.rotation-(PI/2)) * fire_velocity
        current_circle_size = circle_deck[shot_count]["circle_size"]
        this_circle.circle_size = current_circle_size


        shot_count += 1
        ui_circle_feed.ui_shot_count = shot_count

    else:
        if out_of_shots == false:
            player_level += 1
        out_of_shots = true
        #print("out of shots")
