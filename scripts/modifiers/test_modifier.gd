extends "res://scripts/modifiers/modifier.gd"


var test_addend = 1

func calculate(initial) -> float:
    
    test_addend = (test_addend+modifier_quality)*modifier_shininess

    var result = initial + test_addend
    return result
