extends Node
class_name DoubtSystem

enum DOUBT_STAGES {
	PRIME,
	ADULT,
	MIDDLE,
	OLD,
}

var doubt := 3.0:
	get:
		return doubt
	set(value):
		var old_doubt_stage = doubt_stage
		doubt = clamp(value, 0.0, DOUBT_MAX)
		doubt_changed.emit(doubt)
		if old_doubt_stage != doubt_stage:
			doubt_stage_changed.emit(doubt_stage)

var doubt_stage := DOUBT_STAGES.OLD:
	get:
		if doubt > 2.0:
			return DOUBT_STAGES.PRIME
		if doubt > 1.0:
			return DOUBT_STAGES.ADULT
		if doubt > 0.0:
			return DOUBT_STAGES.MIDDLE
		if doubt == 0:
			return DOUBT_STAGES.OLD
		else:
			return DOUBT_STAGES.OLD
	set(value):
		return

@export var DOUBT_STARTING := 3.0
@export var DOUBT_MAX := 3.0
@export var DOUBT_UPTIME_SECS := 5.0

signal doubt_changed(doubt)
signal doubt_stage_changed(doubt_stage)

# Called when the node enters the scene tree for the first time.
func _ready():
	doubt = DOUBT_STARTING

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	doubt = doubt - delta * (1 / DOUBT_UPTIME_SECS)
