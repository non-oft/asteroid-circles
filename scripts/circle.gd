extends RigidBody2D

@onready var collision = $"./CollisionShape2D"
@onready var sprite = $"./Node2D"
@onready var prox_detect = $"./ProxDetect"
@export var attraction_strength_mult :float = 1
@export var repulsion_strength_mult :float = 50


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
		#TODO clean this up?
	



func collision_detect(body):
	if body.is_in_group("circle"):
		if body.circle_size == self.circle_size and not self.is_queued_for_deletion():
			body.queue_free()
			body.set_collision_layer_value(1,false)
			body.set_collision_mask_value(1,false)
			self.linear_velocity = (self.linear_velocity+body.linear_velocity)/2.0
			self.position = (self.position+body.position)/2.0
			print("self position: ", self.position, ". colliding circle position: ", body.position, ". average: ", (self.position+body.position)/2.0)
			print("self velocity: ", self.linear_velocity, ". colliding circle velocity: ", body.linear_velocity, ". average: ", (self.linear_velocity+body.linear_velocity)/2.0)
			self.circle_size += 1
			ScoreHandler.current_score += circle_size
			print(ScoreHandler.current_score)
			#TODO: because velocities are being averaged after collision, behavior is a bit strange; not sure of a good fix but might be worth giving some thought




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.body_entered.connect(collision_detect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:

	var bodies_prox = prox_detect.get_overlapping_bodies()
	if bodies_prox.size() > 0:
		for body in bodies_prox:
			
			if body.is_in_group("circle") and body != self:
				_gravitate_circles(body)
			
			
			elif body.is_in_group("player"):
				_repel_player(body)
				
				
func _gravitate_circles(circle):
	var distance = self.position.distance_to(circle.position)
	var direction = self.position.direction_to(circle.position)
	self.linear_velocity += direction * (1/distance) * attraction_strength_mult

func _repel_player(player):
	var distance = self.position.distance_to(player.position)
	var direction = self.position.direction_to(player.position)
	var ship_velocity_add = direction * (1/distance) * repulsion_strength_mult
	if player.velocity.x + ship_velocity_add.x < 1.5*player.max_speed and player.velocity.x + ship_velocity_add.x > 1.5*-player.max_speed:
		player.velocity.x += ship_velocity_add.x
	if player.velocity.y + ship_velocity_add.y < 1.5*player.max_speed and player.velocity.y + ship_velocity_add.y > 1.5*-player.max_speed:
		player.velocity.y += ship_velocity_add.y 

	#TODO: maybe do ship repulsion in crush detection instead, using that detection area? Much more subtle, less obtrusive/counter-intuitive
	#than unpredictable slow drift away from circles while trying to stay still
	#Might be good to have ship slightly push *away* circles as well, though
