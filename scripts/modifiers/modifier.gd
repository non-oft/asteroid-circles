extends Node

func calculate(_initial) -> float:
    print("ERROR: modifier lacks calculate function")
    return _initial
#TODO: swap out for proper error?

#path to modifier ui packed scene
const MODIFIER_UI_PATH = "res://scenes/packed_scenes/modifier_ui.tscn"




#main variables potentially needed for calculating each score increase:

var modifier_active: bool = true

var circle_size
#resulting size of currently merging circles

var merge_position
#position where merge is happening

var ship_position
#position where the player's ship currently is

var combo:
    set(input):
        combo = input
        update_name_description()
#current combo

var combo_max:
    set(input):
        combo_max = input
        update_name_description()
#max combo achieved this run

var current_score:
    set(input):
        current_score = input
        update_name_description()
#existing score prior to current merge's effects

var current_circles: Array:
    set(input):
        current_circles = input
        update_name_description()
#array containing all circles that currently exist; alternatively maybe this could potentially be a dictionary or something

var full_deck: Array:
    set(input):
        full_deck = input
        update_name_description()
#array containing all circles in the player's current deck (including those already fired), in the current order

var deck_index: int:
    set(input):
        deck_index = input
        update_name_description()
#index of next circle to be fired within player's current deck

var map_size: float:
    set(input):
        map_size = input
        update_name_description()
#current size of the map, based on score (to be passed in from elsewhere, not just calculated again here, in case other random nonsense gets factored in somewhere for some reason?)


var modifier_variable_1: float:
    set(input):
        modifier_variable_1 = input
        apply_qs_all()
var modifier_variable_2: float:
    set(input):
        modifier_variable_2 = input
        apply_qs_all()
var modifier_variable_3: float:
    set(input):
        modifier_variable_3 = input
        apply_qs_all()

var modifier_variable_1_qs: float:
    set(input):
        modifier_variable_1_qs = input
        update_name_description()
var modifier_variable_2_qs: float:
    set(input):
        modifier_variable_2_qs = input
        update_name_description()
var modifier_variable_3_qs: float:
    set(input):
        modifier_variable_3_qs = input
        update_name_description()
#various simple variables to be used by modifiers in different ways, and the q/s adjusted versions of those variables





#quality and shininess of modifier, set when modifier is created, to augment numerical values inside it:

var modifier_quality: int:
    set(input):
        modifier_quality = input
        apply_qs_all()
        update_name_description()
#quality of modifier, from +0 (functional) to +12 (impossible)

var modifier_shininess: float:
    set(input):
        modifier_shininess = input
        apply_qs_all()
        update_name_description()
#shininess of modifier, from *.5(corroded) to *10+ (otherworldly)




#configurable elements to be used in modifiers, to be changed via upgrades in shops or something?:

var modifier_invert: bool = false:
    set(input):
        modifier_invert = input
        update_name_description()
#configurable boolean to invert the behavior of the modifier

var modifier_look_at: int:
    set(input):
        modifier_look_at = input
        update_name_description()
var look_at_key: Array = ["first", "second", "last", "previous", "next", "random"]
#configurable indicator for first, second, last, previous, next, random (int index 0-5 respectively) and key for same

var modifier_circle_size_variable: int:
    set(input):
        modifier_circle_size_variable = input
        update_name_description()
#configurable circle size to be compared against




#constants for initial generation of shininess/quality, to maybe be influenced externally in the future?

var shininess_dist = 1.0
#distribution of shininess curve

var shininess_min = .5
#minimum value for shininess; lower values on distribution curve will be changed to 1.0

var quality_mult = 1.0
#multiplier for chances of higher quality modifiers



#raw input name and description of modifier, to be amended with augmented/upgraded values etc
#input to be formatted as an array, with strings and variables etc in order as they should appear

var modifier_ui_name_raw: Array
var modifier_ui_description_raw: Array


#text for ui; label text will be automatically updated as variables are changed

var modifier_ui_name_label: Label
var modifier_ui_description_label: Label

var modifier_ui_name: String:
    set(text):
        modifier_ui_name = text
        modifier_ui_name_label.text = text

var modifier_ui_description: String:
    set(text):
        modifier_ui_description = text
        modifier_ui_description_label.text = text



#sources for signals
var score_handler = ScoreHandler



#main initialization, to be called with a ready function in any/all modifiers

func modifier_initialize():

    #bringing in ui stuff:
    var modifier_ui = preload(MODIFIER_UI_PATH).instantiate()
    add_child(modifier_ui)
    modifier_ui_name_label = $"./ModifierUI/ModifierName"
    modifier_ui_description_label = $"./ModifierUI/ModifierDescription"


    #hooking up functions to signals and priming them to prevent null values (TODO: add the rest once they're available):
    score_handler.points_added.connect(current_score_update)
    current_score_update(score_handler.current_score)


    #modifier shininess and quality application:
    #TODO: add step to set q/s constants to match or be affected by external factors if applicable prior to shininess/quality calculation
    var rand_int = randi() % 1000
    var rand_float = randfn(1,shininess_dist)
    if rand_float < shininess_min:
        rand_float = 1
    modifier_shininess = rand_float
    if rand_int < quality_mult*1:
        modifier_quality = 12
    elif rand_int < quality_mult*5:
        modifier_quality = 4
    elif rand_int < quality_mult*25:
        modifier_quality = 2
    elif rand_int < quality_mult*200:
        modifier_quality = 1
    else:
        modifier_quality = 0




#function to convert an array of arbitrary strings and variables to a single string.
#(definitely feels like there should be a better way to do this nonsense but heck if I know it)
func text_array_to_string(array:Array) -> String:
    var result: String
    for item in array:
        if typeof(item) != TYPE_STRING:
            result = result + "ERROR_DATATYPE_IN_ARRAY"
        if item.contains("["):
            if item == "[v1]":
                result = result + str(limit_decimals(modifier_variable_1_qs, 2))
            elif item == "[v2]":
                result = result + str(limit_decimals(modifier_variable_2_qs, 2))
            elif item == "[v3]":
                result = result + str(limit_decimals(modifier_variable_3_qs, 2))
            elif item == "[lookat]":
                result = result + str(look_at_key[modifier_look_at])
            elif item == "[csize]":
                result = result + "circle size " + str(modifier_circle_size_variable)
            elif item == "[combo]":
                result = result + str(combo) + " (current combo)"
            elif item == "[combomax]":
                result = result + str(combo_max) + " (max combo reached)"
            elif item == "[score]":
                result = result + str(current_score) + " (current score)"
            elif item == "[deckindex]":
                result = result + str(deck_index) + " (current shot index in deck)"
            elif item == "[mapsize]":
                result = result + str(limit_decimals(map_size, 2)) + " (map size)"
            elif item == "[cnumber]":
                result = result + str(current_circles.size()) + " (current number of circles)"
            elif item == "[decksize]":
                result = result + str(full_deck.size()) + " (current deck size)"
            else:
                result = result + item
        else:
            result = result + item
        
    return result




#function to receive signal from score_handler and update player score dynamically
func current_score_update(score):
    current_score = score


#function to update name and description of modifier, using raw input arrays and current applicable variable values
func update_name_description():
    if modifier_ui_name_raw:
        modifier_ui_name = text_array_to_string(modifier_ui_name_raw)
    else:
        modifier_ui_name = "yer modifier's broken, friend"
    if modifier_ui_description_raw:
        modifier_ui_description = text_array_to_string(modifier_ui_description_raw)
    else:
        modifier_ui_description = "this here is text y'all shouldn't be seeing unless the game is doing something shall we say more than a bit incorrect"




#function to limit the number of decimal places of a float
#TODO: refine at some point to do significant figures instead, or replace with another function that does that?
func limit_decimals(input:float, decimal_places:int) -> float:
    var order_of_magnitude = 10**decimal_places
    return floorf(input*order_of_magnitude)/order_of_magnitude 




#function to apply quality and shininess to a given input
func apply_qs(input) -> float:
    return (input+modifier_quality)*modifier_shininess
    

#function to apply quality and shininess to all variables
func apply_qs_all():
    if modifier_variable_1:
        modifier_variable_1_qs = apply_qs(modifier_variable_1)
    if modifier_variable_2:
        modifier_variable_2_qs = apply_qs(modifier_variable_2)
    if modifier_variable_3:
        modifier_variable_3_qs = apply_qs(modifier_variable_3)
