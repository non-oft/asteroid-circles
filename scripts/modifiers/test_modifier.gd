extends "res://scripts/modifiers/modifier.gd"


func _ready() -> void:
    modifier_initialize("Test Modifier","Adds 1 to score as it's earned.")
    
    #TODO: need to establish system/technique for changing numbers/etc, in this case the 1, dynamically as appropriate
    #will need to update when q/s or the variable(s) or parameters in question change


func calculate(initial) -> float:

    if modifier_active:

        modifier_variable_1 = 1
    
        apply_qs(modifier_variable_1)

        var result = initial + modifier_variable_1
        return result
    else:
        return initial
