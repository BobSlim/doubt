extends Label

@onready var gone_timer = $GoneTimer as Timer
@onready var blip_timer = $BlipTimer as Timer

func queue_say(str: String, length: float = 3.0):
	process_speech(str)
	gone_timer.start(length)

func process_speech(str):
	visible_characters = 0
	text = str

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	visible_characters += 1

func _on_gone_timer_timeout():
	text = ""
