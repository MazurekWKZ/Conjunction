class_name Portal extends Node2D

@onready var portal_area = $Area2D
@export var target_node = Node2D


var state = "free"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if portal_area.has_overlapping_areas() && state == "free":
		state = "busy"
		var detected_areas = portal_area.get_overlapping_areas()
		var parent_object = detected_areas[0].get_parent()
		if target_node.state == "free" && parent_object is Node2D:
			parent_object.is_moving = false
			parent_object.target_position = target_node.global_position
			parent_object.global_position = target_node.global_position
			
		print(state)
	
	if !portal_area.has_overlapping_areas() && state == "busy":
		state = "free"
		print(state)
	pass
