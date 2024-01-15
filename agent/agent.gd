extends CharacterBody2D

const SPEED = 75.0
const JUMP_VELOCITY = -180.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_double_jump = false

enum FACING {
	LEFT,
	RIGHT,
}

var facing = FACING.RIGHT

func _physics_process(delta):
	velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			if $doubt.doubt > 0:
				can_double_jump = true
		elif can_double_jump:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$sprite.scale = Vector2(direction, 1)
		$sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$sprite.play("default")
	
	move_and_slide()
