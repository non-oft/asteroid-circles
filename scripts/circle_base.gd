extends RigidBody2D


var collision
var sprite
var prox_detect
var size_label
var player_ship
var main_scene

var wrap_scale = 100.0
#default size 200.0

var is_ghost_circle: bool = false
var ghost_circle_index: int
var ghost_of


const GHOST_CIRCLE_PATH = "res://scenes/packed_scenes/ghost_circle.tscn"



func circle_initialize():
    collision = $"./CollisionShape2D"
    sprite = $"./Node2D"
    prox_detect = $"./ProxDetect"
    size_label = $"./SizeLabel"
    player_ship = get_tree().get_root().get_node("Main/Ship")
    main_scene = get_tree().get_root().get_node("Main")

    

func create_ghost_circles():
    for ghost_circle in range(6):
        var new_circle = preload(GHOST_CIRCLE_PATH).instantiate()
        main_scene.add_child(new_circle)
        new_circle.ghost_of = self
        new_circle.is_ghost_circle = true
        new_circle.ghost_circle_index = ghost_circle
        new_circle.circle_size = circle_size
        



var circle_size:int:
    set(value):
        circle_size = value
        circle_physics_properties_update(circle_size)


var scale_mult: float = .4
var scale_addend: float = .4

var prox_mult: float = .25
var prox_addend: float = .1

var mass_mult: float = .5
var mass_addend: float = .01

#TODO: set up global variables somewhere for all circles to pull these variables from for consistency and convenience?


func set_circle_visual_scale(circle_size_input:int):
    var circle_scale = (circle_size_input*scale_mult) + scale_addend
    sprite.scale = Vector2(circle_scale,circle_scale)

func set_circle_collision_scale(circle_size_input:int):
    var circle_scale = (circle_size_input*scale_mult) + scale_addend
    collision.scale = Vector2(circle_scale,circle_scale)

func set_circle_prox_scale(circle_size_input:int):
    var circle_scale = (circle_size_input*prox_mult) + prox_addend
    prox_detect.scale = Vector2(circle_scale,circle_scale)

func set_circle_mass(circle_size_input:int):
    var circle_mass = (circle_size_input*mass_mult) + mass_addend
    self.mass = circle_mass

func set_circle_text(circle_size_input:int):
    size_label.text = str(circle_size_input)


func circle_physics_properties_update(circle_size_input:int):
    set_circle_visual_scale(circle_size_input)
    set_circle_collision_scale(circle_size_input)
    set_circle_prox_scale(circle_size_input)
    set_circle_mass(circle_size_input)
    set_circle_text(circle_size_input)

func circle_ui_properties_update(circle_size_input:int):
    if circle_size_input < 0:
        sprite.scale = Vector2(0,0)
        size_label.text = ""
    else:
        set_circle_visual_scale(circle_size_input)
        set_circle_text(circle_size_input)



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



func ghost_position_update():
    circle_size = ghost_of.circle_size
    rotation = ghost_of.rotation
    if ghost_circle_index == 0:
        position.x = ghost_of.position.x-wrap_scale*3.5
        position.y = ghost_of.position.y-wrap_scale*6
    if ghost_circle_index == 1:
        position.x = ghost_of.position.x+wrap_scale*3.5
        position.y = ghost_of.position.y-wrap_scale*6
    if ghost_circle_index == 2:
        position.x = ghost_of.position.x-wrap_scale*7
        position.y = ghost_of.position.y
    if ghost_circle_index == 3:
        position.x = ghost_of.position.x+wrap_scale*7
        position.y = ghost_of.position.y
    if ghost_circle_index == 4:
        position.x = ghost_of.position.x-wrap_scale*3.5
        position.y = ghost_of.position.y+wrap_scale*6
    if ghost_circle_index == 5:
        position.x = ghost_of.position.x+wrap_scale*3.5
        position.y = ghost_of.position.y+wrap_scale*6