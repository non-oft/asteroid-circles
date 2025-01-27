extends CharacterBody2D


@export var max_speed:float = 300.0
@export var acceleration:float = 20
@export var deceleration:float = 1.5
@onready var crush_detect:Area2D = $"./crush_detect"
var crush_timer:float = 0
@export var crush_time:float = 10
@export var crush_detect_nudge_strength:float = 20
@onready var firing_system = $FiringSystem


signal shot_fired



func _physics_process(_delta: float) -> void:
    

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var direction_x := Input.get_axis("ui_left", "ui_right")
    if direction_x:
        if velocity.x+direction_x*acceleration<max_speed and velocity.x+direction_x*acceleration>-max_speed:
            velocity.x += direction_x*acceleration
            
    else:
        velocity.x += -velocity.x/deceleration

    var direction_y := Input.get_axis("ui_up", "ui_down")
    if direction_y:
        if velocity.y+direction_y*acceleration<max_speed and velocity.y+direction_y*acceleration>-max_speed:
            velocity.y += direction_y*acceleration

    else:
        velocity.y += -velocity.y/deceleration
        #TODO: global scope clamp on simple addition of acceleration modified inputs instead of resetting every cycle?

    look_at(get_global_mouse_position())
    self.rotation+= PI/2

    move_and_slide()

    check_for_fire()
    check_for_reload()

    #crush detection and ship nudging (attempting to minimally move ship out of danger):
    #print(crush_detect.get_overlapping_bodies().filter(func(body): return body.is_in_group("circle")))
    if crush_detect.get_overlapping_bodies().filter(func(body): return body.is_in_group("circle")):
        crush_timer += 1.0/60
        #print("ship is being crushed! :o ",crush_timer)
    else:
        if crush_timer > 0:
            crush_timer -= crush_time/3
        else:
            crush_timer = 0

    if crush_timer >= crush_time:
        crush_timer = crush_time
        print("ship has been crushed :(")

    for body in crush_detect.get_overlapping_bodies():
        if body.is_in_group("circle"):
            self.velocity += Vector2(1,1)/(self.position-body.position)*crush_detect_nudge_strength

    #(not doing crush detection or nudging for walls for now because it seems like they may not exist soon...?)
    #TODO: nudge doesn't prevent the player from just rubbing their face on a circle until they get 'crushed', because of the way movement is being handled
    #not sure how to elegantly fix, but that's not intended behavior

    wrap_position()



func check_for_reload():
    if Input.is_action_just_pressed("reload") and firing_system.out_of_shots:
        firing_system.circle_deck_reload()

func check_for_fire():
    if Input.is_action_just_pressed("fire"):
        shot_fired.emit()

func wrap_position():
    if fposmod(position.y, 2400) > 1200:
        position.x = fposmod(position.x+700, 1400)
    else:
        position.x = fposmod(position.x, 1400)
    position.y = fposmod(position.y, 1200)