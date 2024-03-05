extends Sprite2D

@export var oscillation_amplitude = 1.0
@export var oscillation_frequency = 1.0
@export var shake_range = 0.0002

var counter = randf()*2*PI
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter += delta
	offset.y = sin(counter * oscillation_frequency) * oscillation_amplitude
	rotation = randi()%30 * shake_range
	pass
