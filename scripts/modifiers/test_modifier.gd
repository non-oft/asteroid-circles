extends "res://scripts/modifiers/modifier.gd"


func _ready() -> void:
    modifier_ui_name_raw = ["Test Modifier"]
    modifier_ui_description_raw = ["Adds ", "[v1]", " to score as it's earned."]
    
    
    modifier_initialize()

    modifier_variable_1 = 1
    print ("quality: "+str(modifier_quality)+" shininess: "+str(modifier_shininess)+"; variable 1 raw: "+str(modifier_variable_1)+ " variable 1 qs adjusted: "+str(modifier_variable_1_qs))
    
    


func calculate(initial) -> float:

    if modifier_active:
        var result = initial + modifier_variable_1_qs
        return floori(result)
    else:
        return initial
#floor after calculation, before return, not on individual variables (doesn't matter here, but would make a difference in other cases)
#TODO maybe even floor in the end after all calculations, not within modifiers?