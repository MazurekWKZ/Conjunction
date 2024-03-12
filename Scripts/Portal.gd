class_name Portal extends Node2D

@onready var portal_area = $Area2D

@export var target_node: Portal
@export var marker_sprite: SignSprite

var state = "free"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if marker_sprite != null:
		if state == "busy" || target_node.state == "busy":
			marker_sprite.alpha_factor = 0.35
		else:
			marker_sprite.alpha_factor = 0.75
			
	if portal_area.has_overlapping_areas() && state == "free":
		state = "busy"
		var detected_areas = portal_area.get_overlapping_areas()
		var parent_object = detected_areas[0].get_parent()
		if target_node.state == "free" && parent_object is Node2D:
			target_node.state = "wait"
			parent_object.is_moving = false
			parent_object.target_position = target_node.global_position
			parent_object.global_position = target_node.global_position		
		print(state)
	
	if !portal_area.has_overlapping_areas() && state == "busy":
		state = "free"
		print(state)
	
	if portal_area.has_overlapping_areas() && state == "wait":
		state = "busy"	
