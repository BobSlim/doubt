extends Label

var say_queue: PackedStringArray = PackedStringArray([])
@export var say_queue_start: PackedStringArray = PackedStringArray([])

func queue_say(str: String, infinite: bool = false):
	say_queue.append(str)

func process_speech():
	text = "\n".join(say_queue)
	visible_characters = max(0, visible_characters - say_queue[0].length())
	say_queue.remove_at(0)

func set_time(time):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	say_queue = say_queue_start
	queue_say("hello I am person")
	queue_say("how are you today")
	queue_say("how are you today")
	queue_say("how are you today")
	process_speech()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	visible_characters = visible_characters + 1
