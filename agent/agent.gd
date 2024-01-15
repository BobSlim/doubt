extends CharacterBody2D

const SPEED = 75.0
const JUMP_VELOCITY = -180.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_double_jump = false
var stage = "Stage_1_"

var stageWalk = stage + "Walk"
var stageDefault = stage + "Default"
var stageJump = stage + "Jumping"

func _ready():
	pass

func _process(delta):
	if $doubt.doubt < 0.5:
				stage = "Stage_1_"
				stageWalk = stage + "Walk"
				stageDefault = stage + "Default"
				stageJump = stage + "Jumping"
	elif $doubt.doubt < 1.0:
				stage = "Stage_2_"
				stageWalk = stage + "Walk"
				stageDefault = stage + "Default"
				stageJump = stage + "Jumping"
	elif $doubt.doubt < 1.5:
				stage = "Stage_3_"
				stageWalk = stage + "Walk"
				stageDefault = stage + "Default"
				stageJump = stage + "Jumping"
	elif $doubt.doubt < 2.0:
				stage = "Stage_4_"
				stageWalk = stage + "Walk"
				stageDefault = stage + "Default"
				stageJump = stage + "Jumping"
	pass

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
	var is_right = true if direction >= 0 else false
	if direction:
		velocity.x = direction * SPEED
		$sprite.flip_h = !is_right
		$sprite.play(stageWalk)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$sprite.play(stageDefault)
	
	move_and_slide()
