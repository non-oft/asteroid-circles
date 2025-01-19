extends Node

func calculate(_initial) -> float:
    print("Error: modifier lacks calculate function")
    return 0.0
#TODO: swap out for proper error?

#path to modifier ui packed scene
const MODIFIER_UI_PATH = "res://scenes/packed_scenes/modifier_ui.tscn"



#main variables potentially needed for calculating each score increase:

var modifier_active: bool = true

var circle_size
#resulting size of currently merging circles

var combo
#current combo

var combo_max
#max combo achieved this run

var current_score
#existing score prior to current merge's effects

var merge_position
#position where merge is happening

var ship_position
#position where the player's ship currently is

var current_circles: Array
#array containing all circles that currently exist; alternatively maybe this could potentially be a dictionary or something

var full_deck: Array
#array containing all circles in the player's current deck (including those already fired), in the current order

var deck_index: int
#index of next circle to be fired within player's current deck

var map_size
#current size of the map, based on score (to be passed in from elsewhere, not just calculated again here, in case other random nonsense gets factored in somewhere for some reason?)


var modifier_variable_1: float
var modifier_variable_2: float
var modifier_variable_3: float
#various simple variables to be used by modifiers in different ways




#quality and shininess of modifier, set when modifier is created, to augment numerical values inside it:

var modifier_quality: int
#quality of modifier, from +0 (functional) to +12 (impossible)

var modifier_shininess: float
#shininess of modifier, from *.5(corroded) to *10+ (otherworldly)




#configurable elements to be used in modifiers, to be changed via upgrades in shops or something?:

var modifier_invert: bool = false
#configurable boolean to invert the behavior of the modifier

var modifier_look_at: int
#configurable indicator for left, right, first, last, etc; TODO replace this comment with a proper reference list and use an int value

var modifier_circle_size: int
#configurable circle size to be compared against




#constants for shininess/quality, to maybe be influenced externally in the future?

var shininess_dist = 1.0
#distribution of shininess curve

var shininess_min = .5
#minimum value for shininess; lower values on distribution curve will be changed to 1.0

var quality_mult = 1.0
#multiplier for chances of higher quality modifiers



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



#main initialization, to be called with a ready function in any/all modifiers

func modifier_initialize(modifier_ui_name_input: String, modifier_ui_description_input: String):
       
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
	

    #bringing in ui stuff and setting initial label text:

    var modifier_ui = preload(MODIFIER_UI_PATH).instantiate()
    add_child(modifier_ui)
    modifier_ui_name_label = $"./ModifierUI/ModifierName"
    modifier_ui_description_label = $"./ModifierUI/ModifierDescription"


    if modifier_ui_name_input:
        modifier_ui_name = modifier_ui_name_input
    else:
        modifier_ui_name = "yer modifier's broken, friend"
    if modifier_ui_description_input:
        modifier_ui_description = modifier_ui_description_input
    else:
        modifier_ui_description = "this here is text y'all shouldn't be seeing unless the game is doing something shall we say more than a bit incorrect"




#function to apply quality and shininess to a given input
func apply_qs(input) -> float:
    return (input+modifier_quality)*modifier_shininess
