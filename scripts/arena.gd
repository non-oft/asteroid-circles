extends StaticBody2D

##The multiplier that the scale of the arena will grow by
@export var scale_multiplier: float = 2

var scale_cap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale_cap = scale * scale_multiplier


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ScoreHandler.current_score >= 10: 
		scale = lerp(scale, scale_cap, 3 * delta) 

		if $Camera2D.zoom.x != 1:
			$Camera2D.zoom = lerp($Camera2D.zoom,Vector2(1,1), 3 * delta) 
