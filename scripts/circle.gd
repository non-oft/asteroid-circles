extends RigidBody2D

@onready var collision = $"./CollisionShape2D"
@onready var sprite = $"./Node2D"
@onready var prox_detect = $"./ProxDetect"
@export var attraction_strength_mult :float = 1
@export var repulsion_strength_mult :float = 100


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
		circle_size = value






func collision_detect(body):
	#print("collision detected")
	if body.is_in_group("circle"):
		if body.circle_size == self.circle_size:
			print("balls touched: ", body.circle_size, " ", self.circle_size)


		#else:
			
			#print ("mismatched balls touched")
			#pass




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.body_entered.connect(collision_detect)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:

	var bodies_prox = prox_detect.get_overlapping_bodies()
	if bodies_prox.size() > 0:
		for body in bodies_prox:
			
			if body.is_in_group("circle") and body != self:
				var distance = self.position.distance_to(body.position)
				var direction = self.position.direction_to(body.position)
				self.linear_velocity += direction * (1/distance) * attraction_strength_mult
			
			
			elif body.is_in_group("player"):
				var distance = self.position.distance_to(body.position)
				var direction = self.position.direction_to(body.position)
				body.velocity += -direction * (1/distance) * repulsion_strength_mult
				#TODO: doesn't seem to be working?
				