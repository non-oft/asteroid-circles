extends Control


var sprite
var size_label

var circle_index:int
var circle_size:int:
    set(value):
        circle_size = value
        circle_ui_properties_update(circle_size)


var scale_mult: float = .4
var scale_addend: float = .4


func circle_ui_initialize():
    sprite = $Node2D
    size_label = $SizeLabel


func set_circle_visual_scale(_circle_size:int):
    var circle_scale = (_circle_size*scale_mult) + scale_addend
    sprite.scale = Vector2(circle_scale,circle_scale)

func set_circle_text(_circle_size:int):
    size_label.text = str(_circle_size)


func circle_ui_properties_update(_circle_size:int):
    if _circle_size < 0:
        sprite.scale = Vector2(0,0)
        size_label.text = ""
    else:
        set_circle_visual_scale(_circle_size)
        set_circle_text(_circle_size)
