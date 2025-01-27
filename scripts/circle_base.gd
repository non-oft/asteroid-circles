extends RigidBody2D


var collision
var sprite
var prox_detect
var size_label
var player_ship

var wrap_scale = 100.0
#default size 200.0


func circle_initialize():
    collision = $"./CollisionShape2D"
    sprite = $"./Node2D"
    prox_detect = $"./ProxDetect"
    size_label = $"./SizeLabel"
    player_ship = get_tree().get_root().get_node("Main/Ship")



var scale_mult: float = .25
var scale_addend: float = .4

var prox_mult: float = .25
var prox_addend: float = .4

var mass_mult: float = .25
var mass_addend: float = .4

#TODO: set up global variables somewhere for all circles to pull these variables from for consistency and convenience?


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



func wrap_position_circle():
    var x_size = wrap_scale*7
    var y_size = wrap_scale*6

    var s_pos_x = player_ship.position.x-x_size/2
    var s_pos_y = player_ship.position.y-y_size/2

    if fposmod(position.y-s_pos_y, y_size*2) > y_size:
        position.x = fposmod(position.x-s_pos_x+x_size/2, x_size)+s_pos_x
    else:
        position.x = fposmod(position.x-s_pos_x, x_size)+s_pos_x
    position.y = fposmod(position.y-s_pos_y, y_size)+s_pos_y