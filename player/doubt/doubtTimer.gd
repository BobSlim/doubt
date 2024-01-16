extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_doubt_doubt_changed(doubt):
	var integral = int(doubt)
	var fractional = doubt - integral
	# this allows for the eight section bar.
	$barMain.value = ceil(fractional * 8)
	$bar1.value = 1 if integral >= 1 else 0
	$bar2.value = 1 if integral >= 2 else 0
