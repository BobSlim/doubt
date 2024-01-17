extends CharacterBody2D

const SPEED = 50.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $Sprite2D

const MOVE_CYCLE = [0, 1, 0, 0, -1, 0, 0, -1, 0, 0, 1, 0]
var move_cycle_stage = 0
var direction = 0

func _on_timer_timeout():
	move_cycle_stage = move_cycle_stage + 1
	direction = MOVE_CYCLE[move_cycle_stage % MOVE_CYCLE.size()]

func _ready():
	direction = MOVE_CYCLE[move_cycle_stage]

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var is_right = true if direction >= 0 else false
	if direction:
		velocity.x = direction * SPEED
		sprite.play("walk")
		sprite.flip_h = !is_right
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play("default")

	move_and_slide()
