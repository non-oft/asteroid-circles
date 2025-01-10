extends VBoxContainer

@export var preview_number = 6
var circle_array
@onready var label = $"../Label"
@export var circle:PackedScene



var shot_count = 0:
	set(value):
		increment_circles_animation_start()
		


func increment_circles_animation_start():
	print("increment circles animation triggered with shot count ", shot_count)
	for child in get_children():
		child.circle_size = circle_array[shot_count+child.circle_index]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if circle:
		for index in range(preview_number):
			var this_circle = circle.instantiate()
			self.add_child(this_circle)
			print("added child ", this_circle, " to ", this_circle.get_parent().name)
			this_circle.circle_index = index


		


	else:
		print("missing circle_ui PackedScene")
	
	increment_circles_animation_start()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
