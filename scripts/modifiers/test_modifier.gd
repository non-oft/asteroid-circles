extends "res://scripts/modifiers/modifier.gd"


func _ready() -> void:
    modifier_initialize()
    modifier_ui_name = "Test Modifier"
    modifier_ui_description = "Adds 1 to score as it's earned."
    #TODO: need to establish system/technique for changing numbers/etc, in this case the 1, dynamically as appropriate


func calculate(initial) -> float:
    
    modifier_variable_1 = 1
    
    apply_qs(modifier_variable_1)

    var result = initial + modifier_variable_1
    return result
