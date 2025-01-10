extends Control

var circle_index:int
var circle_size:int:
	set(value):
		var circle_scale = (value*.25) +.4
		print("circle scale ", circle_scale)
		#TODO fix magic numbers?
		sprite.scale = Vector2(circle_scale,circle_scale)
var sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite = $"./Node2D"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
