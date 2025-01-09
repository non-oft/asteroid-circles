extends CharacterBody2D


@export var speed:float = 300.0
@export var acceleration:float = 20


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

	move_and_slide()

	check_for_fire()


func check_for_fire():
	if Input.is_action_just_pressed("fire"):
		print("shot fired")