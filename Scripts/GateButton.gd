class_name GateButton extends Node2D

@onready var button_sprite = $AnimatedSprite2D
@onready var button_area = $Area2D

var state = "not_pressed"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if button_area.has_overlapping_areas() && state != "pressed":
		state = "pressed"
		button_sprite.set_frame_and_progress(1, 0.0)
		button_sprite.z_index -= 1
		print(state)
	
	if !button_area.has_overlapping_areas() && state == "pressed":
		state = "not_pressed"
		button_sprite.set_frame_and_progress(0, 0.0)
		button_sprite.z_index += 1
		print(state)
	pass


