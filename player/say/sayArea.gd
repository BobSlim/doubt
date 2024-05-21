extends Area2D
@export_multiline var speech = "Wow, what a place."
@export var active = true

var has_seen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if !has_seen and active and body.has_method("queue_say"):
		body.queue_say(speech)
	has_seen = true
