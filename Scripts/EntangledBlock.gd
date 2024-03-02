extends Block

@onready var block_sprite = $AnimatedSprite2D

@export var sibling_node: Block

# Called when the node enters the scene tree for the first time.
func _ready():
	block_sprite.frame = randi()%7
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sibling_move(direction: Vector2):
	super.move(direction)
	
func move(direction: Vector2):
	super.move(direction)
	if !sibling_node.is_locked && !sibling_node.is_falling:
		sibling_node.sibling_move(direction)

