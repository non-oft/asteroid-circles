extends Node2D

@export var level_circle_count := 10
@export var level_circle_range := 4
# TODO: hook these properly to level properties?
@export var circle:PackedScene
@export var fire_distance:float = 30
@export var fire_velocity:float = 10
var root_node
var ship
var circle_array = []
var shot_count := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ship = $".."
	root_node = get_tree().get_root().get_node("Main")
	for index in range(level_circle_count):
		var random = randi_range(0,level_circle_range)
		print(random)
		circle_array.append(random)

	print(circle_array)

func on_shot_fired():
	# print("shot fired")
	shot_count += 1
	print(shot_count)
	var this_circle=circle.instantiate()
	root_node.add_child(this_circle)
	this_circle.position = ship.position + Vector2.from_angle(ship.rotation-(PI/2)) * fire_distance
	this_circle.linear_velocity = Vector2.from_angle(ship.rotation-(PI/2)) * fire_velocity
	# print(this_circle.get_parent().name)
	print(ship.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
