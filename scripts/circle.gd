extends RigidBody2D

var collision
var sprite

var size:int:
	set(value):
		var circle_scale = value +1
		collision.scale = Vector2(circle_scale,circle_scale)
		sprite.scale = Vector2(circle_scale,circle_scale)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision = $"./CollisionShape2D"
	sprite = $"./Node2D"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
