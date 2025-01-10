extends CharacterBody2D


@export var speed:float = 300.0
@export var acceleration:float = 20
#@export var circle:PackedScene
#@export var fire_distance:float = 30
#@export var fire_velocity:float = 10
#var my_parent
var crush_detect:Area2D


signal shot_fired

func _ready() -> void:
	#my_parent = $".."
	crush_detect = $"./crush_detect"
	# print(crush_detect)

func _on_body_enter(body):
	if body.is_in_group("circle"):
		print(body)

		#note: use CollisionObject2d's 'has_overlapping_bodies' to check for crushing instead of signals? (test)


func _physics_process(_delta: float) -> void:
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x := Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = move_toward(velocity.x, direction_x * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration)

	var direction_y := Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = move_toward(velocity.y, direction_y * speed, acceleration)
	else:
		velocity.y = move_toward(velocity.y, 0, acceleration)
		

	look_at(get_global_mouse_position())
	self.rotation+= PI/2

	#var rotation_var := Input.get_axis("ui_left", "ui_right")
	#if rotation_var:
	#	self.rotation = move_toward(self.rotation, rotation_var * speed*.001, acceleration*.001)
	#else:
	#	self.rotation = move_toward(self.rotation, 0, acceleration*.001)

	move_and_slide()

	check_for_fire()


func check_for_fire():
	if Input.is_action_just_pressed("fire"):
		# print("shot fired")
		shot_fired.emit()
		#var this_circle=circle.instantiate()
		#my_parent.add_child(this_circle)
		#this_circle.position = self.position + Vector2.from_angle(self.rotation-(PI/2)) * fire_distance
		#this_circle.linear_velocity = Vector2.from_angle(self.rotation-(PI/2)) * fire_velocity
