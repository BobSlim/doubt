extends CharacterBody2D

const SPEED = 75.0
const JUMP_VELOCITY = -180.0

@onready var DoubtNode = $doubt as DoubtSystem

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_double_jump = false
var stageWalk: String
var stageDefault: String
var stageJump: String

func update_animation_stage(new_stage: String):
	stageWalk = new_stage + "Walk"
	stageDefault = new_stage + "Default"
	stageJump = new_stage + "Jumping"

func doubt_stage(doubt: float):
	var stage = "Stage_4_"
	if doubt < 0.5:
		stage = "Stage_1_"
	elif doubt < 1.0:
		stage = "Stage_2_"
	elif doubt < 1.5:
		stage = "Stage_3_"
	else:
		stage = "Stage_4_"
	return stage

func _ready():
	pass

func _process(delta: float):
	var stage = doubt_stage(DoubtNode.doubt)
	update_animation_stage(stage)

func _physics_process(delta: float):
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
