extends "res://scripts/circle_base.gd"


#var circle_size:int:
	#set(value):
		#circle_size = value
		#circle_physics_properties_update(circle_size)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	circle_initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if ghost_of.is_queued_for_deletion():
		queue_free()
	else:
		ghost_position_update()
