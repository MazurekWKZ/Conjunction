class_name Gate extends Node2D

@onready var exit_handler = $"../ExitHandler"
@onready var gate_sprite = $"GateDoor"
@onready var tile_map = $"../TileMap"
@onready var collider = $GateArea
@export var next_level_path = "res://Levels/MainMenu.tscn"
@export var number_of_players = 1

var state = "closed"
var entered = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if collider.has_overlapping_areas() && state == "open":
		var counted_players = 0
		if collider.get_overlapping_areas().size() == number_of_players:
			var collided_areas = collider.get_overlapping_areas()
			for collided_area in collided_areas:
				var collided_node = collided_area.get_parent()
				if collided_node is Player && !entered:
					counted_players += 1
			if counted_players == number_of_players:
				entered = true
				exit_handler.next_level(next_level_path)

	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	var tile_data: TileData = tile_map.get_cell_tile_data(0, current_tile)
	
	if state =="open":
		gate_sprite.rotation_degrees = lerp(gate_sprite.rotation_degrees, 35.0, 0.1)
		gate_sprite.skew = lerp(gate_sprite.skew, -60.0 * 0.01, 0.1)
		gate_sprite.position.x = lerp(gate_sprite.position.x, 7.0, 0.1)
		"gate_sprite.position.y = lerp(gate_sprite.position.y, -21.34, 0.1)"
		gate_sprite.scale.x = lerp(gate_sprite.scale.x, 0.5, 0.1)
		var tile_map_cell_source_id = tile_map.get_cell_source_id(0, current_tile)
		var tile_map_cell_alternative = tile_map.get_cell_alternative_tile(0, current_tile) 
		tile_map.set_cell(0, current_tile, tile_map_cell_source_id, Vector2i(0,0), tile_map_cell_alternative)
	else:
		gate_sprite.rotation_degrees = lerp(gate_sprite.rotation_degrees, 0.0, 0.1)
		gate_sprite.skew = lerp(gate_sprite.skew, 0.0, 0.1)
		gate_sprite.position.x = lerp(gate_sprite.position.x, 0.0, 0.1)
		"gate_sprite.position.y = lerp(gate_sprite.position.y, -21.34, 0.1)"
		gate_sprite.scale.x = lerp(gate_sprite.scale.x, 1.0, 0.1)
		var tile_map_cell_source_id = tile_map.get_cell_source_id(0, current_tile)
		var tile_map_cell_alternative = tile_map.get_cell_alternative_tile(0, current_tile) 
		tile_map.set_cell(0, current_tile, tile_map_cell_source_id, Vector2i(2,0), tile_map_cell_alternative)
