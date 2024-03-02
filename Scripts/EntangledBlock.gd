extends Block


@export var sibling_node: Block


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sibling_move(direction: Vector2):
	super.move(direction)
	
func move(direction: Vector2):
	super.move(direction)
	sibling_node.sibling_move(direction)

