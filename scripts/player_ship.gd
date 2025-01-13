extends CharacterBody2D


@export var max_speed:float = 300.0
@export var acceleration:float = 20
@export var deceleration:float = 1.5
#@export var circle:PackedScene
#@export var fire_distance:float = 30
#@export var fire_velocity:float = 10
#var my_parent
@onready var crush_detect:Area2D = $"./crush_detect"


signal shot_fired

func _ready() -> void:
	pass

func _on_body_enter(body):
	if body.is_in_group("circle"):
		pass
		#TODO: use area2d's 'get_overlapping_bodies' to check for crushing instead of signals? (test)


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


func check_for_fire():
	if Input.is_action_just_pressed("fire"):
		shot_fired.emit()
