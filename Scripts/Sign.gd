class_name SignSprite extends Sprite2D

@export var offset_factor = 3
@export var offset_speed = 1.0
@export var alpha_factor = 0.5
@export var rotation_factor = 0.3

var time = randi()%30
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	modulate.a = alpha_factor
	offset.y = sin(time * offset_speed) * offset_factor
	rotation_degrees = (randi()%10 - 5) * rotation_factor
	pass
