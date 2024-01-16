extends Area2D

@export var confidence_boost = 0.5
@onready var sprite = $AnimatedSprite2D as AnimatedSprite2D
@export var sprite_set: SpriteFrames

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	body.pickup(confidence_boost)
	queue_free()
