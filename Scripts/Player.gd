class_name Player extends Node2D


@onready var tile_map = $"../TileMap"
@onready var raycast_player = $RayCast2D
@onready var sprite_player = $AnimatedSprite2D
@onready var player_area = $Area2D

@export var walking_speed = 2

var is_moving = false
var is_pushing = false
@onready var target_position = position
var player_state = "alive"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_moving:
		return
	if player_state == "dead":
		sprite_player.play("dead")
		return
		
	if Input.is_action_pressed("ui_up"):
		move(Vector2.UP)
		if is_pushing:
			sprite_player.play("push_up")
		else: 
			sprite_player.play("walk")
	elif Input.is_action_pressed("ui_down"):
		move(Vector2.DOWN)
		if is_pushing:
			sprite_player.play("push_down")
		else: 
			sprite_player.play("walk")
	elif Input.is_action_pressed("ui_left"):
		move(Vector2.LEFT)
		if is_pushing:
			sprite_player.play("push")
		else: 
			sprite_player.play("walk")
		sprite_player.flip_h = 1
	elif Input.is_action_pressed("ui_right"):
		move(Vector2.RIGHT)
		if is_pushing:
			sprite_player.play("push")
		else: 
			sprite_player.play("walk")
		sprite_player.flip_h = 0
	else:
		is_pushing = false
		sprite_player.play("idle")
	
func _physics_process(delta):
	if player_area != null:	
		player_area.position = target_position - global_position
	if player_area != null:
		player_area.position = target_position - global_position
				
	if !is_moving:
		return
	
	if is_moving:
		if global_position == target_position:
			is_moving = false
			return
		if global_position.y == target_position.y:
			global_position = global_position.move_toward(target_position, walking_speed)
		else:
			global_position = global_position.move_toward(target_position, walking_speed/1.3)
		return

func move(direction: Vector2):
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	var target_tile: Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	var tile_data: TileData = tile_map.get_cell_tile_data(0, target_tile)
	
	raycast_player.target_position = Vector2(direction.x * 32, direction.y * 16)
	raycast_player.force_raycast_update()
	
	var move_result = true
	var pass_through = false
	if raycast_player.is_colliding():
		var detected_object = raycast_player.get_collider().get_parent()
		if detected_object is Block:
			move_result = detected_object.move(direction)
			pass_through = detected_object.is_locked
			is_pushing = true
		if detected_object is Player:
			return
	
	if (tile_data.get_custom_data("walkable") && move_result) || pass_through:
		is_moving = true
		target_position = tile_map.map_to_local(target_tile)
		return is_moving
	elif tile_data.get_custom_data("hole"):
		is_pushing = false
		is_moving = false
	else:	
		is_pushing = true
