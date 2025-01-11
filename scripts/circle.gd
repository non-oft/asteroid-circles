extends RigidBody2D

@onready var collision = $"./CollisionShape2D"
@onready var sprite = $"./Node2D"
@onready var prox_detect = $"./ProxDetect"

var circle_size:int:
	set(value):
		var circle_scale = (value*.25) +.4
		#TODO fix magic numbers?
		collision.scale = Vector2(circle_scale,circle_scale)
		sprite.scale = Vector2(circle_scale,circle_scale)

		var prox_scale = (value*.25) +.4
		#TODO fix magic numbers?
		prox_detect.scale = Vector2(prox_scale,prox_scale)
		sprite.scale = Vector2(prox_scale,prox_scale)


func prox_detect_entered(body):
	if body.is_in_group("circle"):
		
			print("balls close")



func collision_detect(body):
	print("collision detected")
	if body.is_in_group("circle"):
		if body.circle_size == circle_size:
			print("balls touched")
		else:
			print ("mismatched balls touched")




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prox_detect.body_entered.connect(prox_detect_entered)
	self.body_entered.connect(collision_detect)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
