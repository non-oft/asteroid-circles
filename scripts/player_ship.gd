extends CharacterBody2D


@export var max_speed:float = 300.0
@export var acceleration:float = 20
@export var deceleration:float = 1.5
#@export var circle:PackedScene
#@export var fire_distance:float = 30
#@export var fire_velocity:float = 10
#var my_parent
@onready var crush_detect:Area2D = $"./crush_detect"
var crush_timer:float = 0
@export var crush_time:float = 10
@export var crush_detect_nudge_strength:float = 20


signal shot_fired

func _ready() -> void:
	pass

func _on_body_enter(body):
	if body.is_in_group("circle"):
		pass
		#print(body)

		#TODO: use area2d's 'get_overlapping_bodies' to check for crushing instead of signals? (test)


func _physics_process(_delta: float) -> void:
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x := Input.get_axis("ui_left", "ui_right")
	if direction_x:
		#velocity.x = move_toward(velocity.x, direction_x * speed, acceleration)
		if velocity.x+direction_x*acceleration<max_speed and velocity.x+direction_x*acceleration>-max_speed:
			velocity.x += direction_x*acceleration
			
	else:
		#velocity.x = move_toward(velocity.x, 0, acceleration)
		velocity.x += -velocity.x/deceleration

	var direction_y := Input.get_axis("ui_up", "ui_down")
	if direction_y:
		#velocity.y = move_toward(velocity.y, direction_y * speed, acceleration)
		if velocity.y+direction_y*acceleration<max_speed and velocity.y+direction_y*acceleration>-max_speed:
			velocity.y += direction_y*acceleration

	else:
		#velocity.y = move_toward(velocity.y, 0, acceleration)
		velocity.y += -velocity.y/deceleration
		#TODO: global scope clamp on simple addition of acceleration modified inputs instead of resetting every cycle?

	look_at(get_global_mouse_position())
	self.rotation+= PI/2

	#var rotation_var := Input.get_axis("ui_left", "ui_right")
	#if rotation_var:
	#	self.rotation = move_toward(self.rotation, rotation_var * speed*.001, acceleration*.001)
	#else:
	#	self.rotation = move_toward(self.rotation, 0, acceleration*.001)

	move_and_slide()

	check_for_fire()

	#crush detection and ship nudging (attempting to minimally move ship out of danger):
	#print(crush_detect.get_overlapping_bodies().filter(func(body): return body.is_in_group("circle")))
	if crush_detect.get_overlapping_bodies().filter(func(body): return body.is_in_group("circle")):
		crush_timer += 1.0/60
		print("ship is being crushed! :o ",crush_timer)
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




func check_for_fire():
	if Input.is_action_just_pressed("fire"):
		# print("shot fired")
		shot_fired.emit()
		#var this_circle=circle.instantiate()
		#my_parent.add_child(this_circle)
		#this_circle.position = self.position + Vector2.from_angle(self.rotation-(PI/2)) * fire_distance
		#this_circle.linear_velocity = Vector2.from_angle(self.rotation-(PI/2)) * fire_velocity
