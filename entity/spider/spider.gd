extends StaticBody2D

@onready var Ray = $RayCast2D as RayCast2D
@onready var Sprite = $AnimatedSprite2D as AnimatedSprite2D
@onready var ResetTimer = $Timer as Timer

var active = false

func activate():
	if active:
		pass
	else:
		active = true
		Sprite.play("activate")
	ResetTimer.start()

func deactivate():
	active = false
	Sprite.play("deactivate")
	
func _on_timer_timeout():
	deactivate()

func _on_animated_sprite_2d_animation_finished():
	match Sprite.animation:
		"deactivate":
			Sprite.play("default")
			set_collision_layer_value(3, false)
		"activate":
			set_collision_layer_value(3, true)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Ray.rotation = Ray.rotation + PI * delta
	var collided = Ray.get_collider()
	if collided and collided.is_in_group("player"):
		activate()
