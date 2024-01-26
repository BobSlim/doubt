extends CharacterBody2D

const SPEED = 75.0
const JUMP_ACCEL = -32.0
const JUMP_BOOST_FRAMES = 6
const DJUMP_BOOST_FRAMES = 5
const FPS = 60.0

@onready var DoubtNode = $doubt as DoubtSystem
@onready var WalkAnimator = $walkAnimator as AnimationPlayer
@onready var BodyAnimator = $bodyAnimator as AnimationPlayer
@onready var AttackAnimator = $attackAnimator as AnimationPlayer
@onready var HeadSprite = $body/head as Sprite2D
@onready var AttackArea = $attackArea as Area2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_double_jump = false
var stageWalk: String
var stageDefault: String
var stageJump: String

var jump_frames := 0

func _on_doubt_doubt_stage_changed(new: int, old: int):
	match new:
		DoubtNode.DOUBT_STAGES.OLD:
			HeadSprite.frame = 3
			can_double_jump = false
		DoubtNode.DOUBT_STAGES.MIDDLE:
			HeadSprite.frame = 2
		DoubtNode.DOUBT_STAGES.ADULT:
			HeadSprite.frame = 1
		DoubtNode.DOUBT_STAGES.PRIME:
			HeadSprite.frame = 0
	var OLDER = [DoubtNode.DOUBT_STAGES.OLD, DoubtNode.DOUBT_STAGES.MIDDLE]
	var YOUNGER = [DoubtNode.DOUBT_STAGES.ADULT, DoubtNode.DOUBT_STAGES.PRIME]
	if OLDER.has(new) and YOUNGER.has(old):
		BodyAnimator.play("transition_to_old")
	elif YOUNGER.has(new) and OLDER.has(old):
		BodyAnimator.play("transition_to_young")

func pickup(confidence_boost):
	DoubtNode.doubt = DoubtNode.doubt + confidence_boost

func _ready():
	_on_doubt_doubt_stage_changed(DoubtNode.doubt_stage, DoubtNode.doubt_stage)

func _process(delta: float):
	pass

func process_velocity_y(delta: float):
	if Input.is_action_pressed("ui_select") and jump_frames > 0:
		jump_frames -= 1
		velocity.y += JUMP_ACCEL
	velocity.y += gravity * delta

func _input(event: InputEvent):
	if event.is_action_pressed("ui_select"):
		if is_on_floor():
			velocity.y = JUMP_ACCEL
			jump_frames = JUMP_BOOST_FRAMES
			if $doubt.doubt > 0:
				can_double_jump = true
		elif can_double_jump:
			velocity.y = JUMP_ACCEL
			jump_frames = DJUMP_BOOST_FRAMES
			can_double_jump = false
	
	if event.is_action_pressed("ui_accept"):
		for i in AttackArea.get_overlapping_bodies():
			pickup(0.125)
			i.queue_free()
		AttackAnimator.play("attack")

func _physics_process(delta: float):
	process_velocity_y(delta)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	var is_right = true if direction >= 0 else false
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, 750.0*delta)
		for i in [$body, $body/head, $body/legs, $body/transition, $body/attack]:
			i.flip_h = !is_right
		AttackArea.position.x = 5 if is_right else -5
		WalkAnimator.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, 500.0*delta)
		WalkAnimator.stop()
	move_and_slide()
