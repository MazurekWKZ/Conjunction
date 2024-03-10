extends LevelControler

@onready var button_1 = $"../GateButton"
@onready var button_2 = $"../GateButton2"
@onready var button_3 = $"../GateButton3"
@onready var button_4 = $"../GateButton4"
@onready var button_5 = $"../GateButton5"
@onready var button_6 = $"../GateButton6"
@onready var button_7 = $"../GateButton7"
@onready var pentagram_area = $"../Pentagram/PentagramArea"
@onready var exit_handler = $"../ExitHandler"
@onready var pentagram_audio = $"../Pentagram/PentagramAudio"
@onready var pentagram_sprite = $"../Pentagram"
@onready var player_copy = preload("res://Objects/Player.tscn")
@onready var exit_area = $"../ExitArea"
@onready var entry_area = $"../EntryArea"

@export var next_scene: String
@export var scene_reference: Node2D
# Called when the node enters the scene tree for the first time.

var spawn_position: Vector2
var timer = 0.0
var sequence_length_1 = 5.0
var sequence = 0

func _ready():
	gate.state = "closed"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if sequence == 0:
		if button_1.state == "pressed" && button_2.state == "pressed" && button_3.state == "pressed" &&\
		button_4.state == "pressed" && button_5.state == "pressed" && button_6.state == "pressed" && button_7.state == "pressed":
			gate.state = "open"
		else:
			gate.state = "closed"
		
		if entry_area.has_overlapping_areas():
			var detected_areas = entry_area.get_overlapping_areas()
			var detected_object = detected_areas[0].get_parent()
			if detected_object is Player:
				gate.state = "closed"
				sequence = 1
		
	if sequence == 1:	
		if pentagram_area.has_overlapping_areas():
			var detected_areas = pentagram_area.get_overlapping_areas()
			var parent_object = detected_areas[0].get_parent()
			if parent_object is Player:
				if !pentagram_audio.playing && sequence == 1:
					pentagram_audio.play()
				parent_object.player_state = "dead"
				exit_handler.target_volume_db = -60.0
				spawn_position = parent_object.position
				sequence = 2
	
	if sequence == 2:
		gate.state = "closed"
		pentagram_sprite.rotation = randi()%10 * 0.001
		timer += delta
		if timer > sequence_length_1:
			timer = 0.0
			sequence = 3
	
	if sequence == 3:
		gate.state = "open"
		var player_copy_instance = player_copy.instantiate()
		player_copy_instance.position = spawn_position + Vector2(0.0, -32.0)
		scene_reference.add_child(player_copy_instance)
		sequence = 4
		
	if sequence == 4:
		if exit_area.has_overlapping_areas():
			var overlapping_areas = exit_area.get_overlapping_areas()
			var detected_object = overlapping_areas[0].get_parent()
			if detected_object is Player:
				exit_handler.next_level(next_scene)

