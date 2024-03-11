class_name Block extends Node2D


@onready var tile_map = $"../TileMap"
@onready var raycast_block = $RayCast2D
@onready var collider_block = $Area2D

@export var walking_speed = 2

var is_moving = false
var target_position
var is_locked = false
var is_falling = false

func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	if !is_moving:
		return
	if is_moving:
		if global_position == target_position:
			is_moving = false
			if is_falling:
				is_locked = true
				is_falling = false
				z_index -= 2
				print(z_index)
			return
		if global_position.y == target_position.y:
			global_position = global_position.move_toward(target_position, walking_speed)
		else:
			global_position = global_position.move_toward(target_position, walking_speed/1.3)
		return

func move(direction: Vector2):
	if is_locked:
		return is_locked
	
	if is_falling:
		return !is_falling
	
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	var target_tile: Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	var tile_data: TileData = tile_map.get_cell_tile_data(0, target_tile)
	
	raycast_block.target_position = Vector2(direction.x * 32, direction.y * 16)
	raycast_block.force_raycast_update()
	
	var pass_through = false
	
	if raycast_block.is_colliding():
		var detected_object = raycast_block.get_collider().get_parent()
		if detected_object is Block && detected_object.is_locked:
			is_moving = true
			target_position = tile_map.map_to_local(target_tile)
		return is_moving
		if detected_object is Player:
			print("touched_player")
			is_moving = false
			return

	if tile_data.get_custom_data("walkable"):
		is_moving = true
		pass_through = true
		target_position = tile_map.map_to_local(target_tile)
		
	if tile_data.get_custom_data("hole"):
		is_moving = true
		pass_through = false
		target_position = tile_map.map_to_local(Vector2i(target_tile.x, target_tile.y + 1))
		raycast_block.queue_free()
		collider_block.queue_free()
		is_falling = true
		var tile_map_cell_source_id = tile_map.get_cell_source_id(0, target_tile)
		var tile_map_cell_alternative = tile_map.get_cell_alternative_tile(0, target_tile) 
		tile_map.set_cell(0, target_tile, tile_map_cell_source_id, Vector2i(1,0), tile_map_cell_alternative)
		
	return pass_through
