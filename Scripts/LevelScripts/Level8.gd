extends LevelControler

@onready var button_1 = $"../GateButton"
@onready var button_2 = $"../GateButton2"
@onready var button_3 = $"../GateButton3"

# Called when the node enters the scene tree for the first time.
func _ready():
	gate.state = "closed"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if button_1.state == "pressed" && button_2.state == "pressed" && button_3.state == "pressed":
		gate.state = "open"
	else:
		gate.state = "closed"
