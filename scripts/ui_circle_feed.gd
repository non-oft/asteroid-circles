extends VBoxContainer

@export var preview_number = 6
var circle_array
@onready var label = $"../Label"
@export var circle:PackedScene



var ui_shot_count = 0:
	set(value):
		var shot_count = value
		#print("ui shot count variable updated; is now ", shot_count)
		#increment_circles_animation_start()
		for child in get_children():
			if circle_array.size() > shot_count+child.circle_index:
				child.circle_size = circle_array[shot_count+child.circle_index]
			else:
				child.circle_size = -1
				


#func increment_circles_animation_start():
	#print("increment circles animation triggered with shot count ", shot_count)
	#for child in get_children():
		#child.circle_size = circle_array[shot_count+child.circle_index]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if circle:
		for index in range(preview_number):
			var this_circle = circle.instantiate()
			self.add_child(this_circle)
			this_circle.circle_index = index
			print("added child ", this_circle, " with index ", this_circle.circle_index, " to ", this_circle.get_parent().name)
			

	else:
		print("missing circle_ui PackedScene")
	
	#increment_circles_animation_start()
	for child in get_children():
			if circle_array.size() > child.circle_index:
				child.circle_size = circle_array[child.circle_index]
			else:
				child.circle_size = -1




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
