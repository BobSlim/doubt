extends Node

const DOUBT_UPTIME_SECS := 10.0
const DOUBT_MAX := 2.5

signal doubt_changed(new_doubt)

var doubt := 2.5 :
	get:
		return doubt
	set(value):
		doubt = clamp(value, 0.0, DOUBT_MAX)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	doubt = doubt - delta * (1 / DOUBT_UPTIME_SECS)
	doubt_changed.emit(doubt)
