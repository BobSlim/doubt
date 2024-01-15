extends Node
class_name DoubtSystem

var doubt := 2.5:
	get:
		return doubt
	set(value):
		doubt = clamp(value, 0.0, DOUBT_MAX)
@export var DOUBT_STARTING := 4.0
@export var DOUBT_MAX := 4.0
@export var DOUBT_UPTIME_SECS := 10.0

signal doubt_changed(new_doubt)

# Called when the node enters the scene tree for the first time.
func _ready():
	doubt = DOUBT_STARTING

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	doubt = doubt - delta * (1 / DOUBT_UPTIME_SECS)
	doubt_changed.emit(doubt)
