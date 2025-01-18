extends Node

func calculate(_initial) -> float:
    print("Error: modifier lacks calculate function")
    return 0.0
#TODO: swap out for proper error?



#main variables potentially needed for calculating each score increase:

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
#array containing all circles that currently exist, with circle size as the index; alternatively maybe this could potentially be a dictionary or something

var full_deck: Array
#array containing all circles in the player's current deck (including those already fired), in the current order

var deck_index: int
#index of next circle to be fired within player's current deck

var map_size
#current size of the map, based on score (to be passed in from elsewhere, not just calculated again here, in case other random nonsense gets factored in somewhere for some reason?)


#quality and shininess of modifier, set when modifier is created, to augment numerical values inside it:

var modifier_quality: int
#quality of modifier, from +0 (functional) to +12 (impossible)

var modifier_shininess: float
#shininess of modifier, from *.5(corroded) to *10+ (otherworldly)



#configurable elements to be used in modifiers, to be changed via upgrades in shops or something?:

var modifier_invert: bool
#configurable boolean to invert the behavior of the modifier

var modifier_look_at
#configurable indicator for left, right, first, last, etc; TODO replace this comment with a proper reference list and use an int value

var modifier_circle_size
#configurable circle size to be compared against