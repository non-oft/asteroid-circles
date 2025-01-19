extends RigidBody2D


@onready var collision = $"./CollisionShape2D"
@onready var sprite = $"./Node2D"
@onready var prox_detect = $"./ProxDetect"
@onready var size_label = $"./SizeLabel"



var scale_mult: float = .25
var scale_addend: float = .4

var prox_mult: float = .25
var prox_addend: float = .4

var mass_mult: float = .25
var mass_addend: float = .4


func set_circle_visual_scale(circle_size:int):
    var circle_scale = (circle_size*scale_mult) + scale_addend
    sprite.scale = Vector2(circle_scale,circle_scale)

func set_circle_collision_scale(circle_size:int):
    var circle_scale = (circle_size*scale_mult) + scale_addend
    collision.scale = Vector2(circle_scale,circle_scale)

func set_circle_prox_scale(circle_size:int):
    var circle_scale = (circle_size*prox_mult) + prox_addend
    prox_detect.scale = Vector2(circle_scale,circle_scale)

func set_circle_mass(circle_size:int):
    var circle_mass = (circle_size*mass_mult) + mass_addend
    self.mass = circle_mass

func set_circle_text(circle_size:int):
    size_label.text = str(circle_size)


func circle_physics_properties_update(circle_size:int):
    set_circle_visual_scale(circle_size)
    set_circle_collision_scale(circle_size)
    set_circle_prox_scale(circle_size)
    set_circle_mass(circle_size)
    set_circle_text(circle_size)

func circle_ui_properties_update(circle_size:int):
    if circle_size < 0:
        sprite.scale = Vector2(0,0)
        size_label.text = ""
    else:
        set_circle_visual_scale(circle_size)
        set_circle_text(circle_size)