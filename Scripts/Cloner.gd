class_name Cloner extends Node2D

@onready var portal_area = $Area2D
@onready var player_copy = preload("res://Objects/Player.tscn")
@onready var block_copy = preload("res://Objects/BlockNormal.tscn")

@onready var cloner_sprite = $AnimatedSprite2D

@export var scene_reference: Node2D
@export var target_node: Node2D

var fade_speed = 0.1
var target_fade = 1.0
var state = "available"

# Called when the node enters the scene tree for the first time.
func _ready():
	cloner_sprite.frame = randi()%3
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clone()
	fade(state, delta)


func clone():
	if portal_area.has_overlapping_areas() && state == "available":
		var detected_areas = portal_area.get_overlapping_areas()
		var parent_object = detected_areas[0].get_parent()
		if target_node.state == "available" && parent_object is Node2D:
			print("entered_cloner")
			target_node.state = "spent"
			state = "spent"
			var node_copy
			if parent_object is Player:
				node_copy = player_copy
			elif parent_object is Block:
				node_copy = block_copy
			else:
				node_copy = block_copy 
			var node_copy_instance = node_copy.instantiate()
			node_copy_instance.position = target_node.position
			scene_reference.add_child(node_copy_instance)
			
			cloner_sprite.stop()
			cloner_sprite.set_frame_and_progress(1,0.0)
			target_node.cloner_sprite.stop()
			target_node.cloner_sprite.set_frame_and_progress(0, 0.0)

func fade(state: String, speed: float):
	if state == "spent":
		target_fade = 0.5	
	else:
		target_fade = 1.0
	cloner_sprite.modulate.a += (target_fade - cloner_sprite.modulate.a) * fade_speed
	pass
