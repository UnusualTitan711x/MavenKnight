extends CharacterBody3D

@export_group("Movement")
@export var movement_speed = 8.0
@export var rotation_speed = 12.0
@export var gravity = -30.0

@onready var camera = %Camera3D
@onready var anim_tree: AnimationTree = $Graphics/Knight/AnimationTree

@export var camera_speed = 10.0

var last_move_direction = Vector3.BACK
var movement_direction:Vector3

func _physics_process(delta: float) -> void:
	
	# Get Imout from player
	var raw_input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Get forward and right direction from the camera
	var forward = camera.global_basis.z
	var right = camera.global_basis.x
	
	# Determine the move direction from those
	movement_direction = forward * raw_input.y + right * raw_input.x
	
	movement_direction.y = 0 # To avoid player moving into the ground
	
	# Normalise it
	movement_direction = movement_direction.normalized()
	
	var y_velocity = velocity.y
	velocity.y = 0
	
	# Use velocity to move the player
	velocity = movement_direction * movement_speed
	
	velocity.y = y_velocity + gravity * delta
	
	if movement_direction.length() < 0.2:
		cur_anim = IDLE
		handle_animations()
	else:
		cur_anim = RUN
		handle_animations()
	
	if Input.is_action_just_pressed("dash"):
		dash()
		move_and_slide()
	
	move_and_slide()
	
	if movement_direction.length() > 0.2:
		last_move_direction = movement_direction
	var target_angle = Vector3.BACK.signed_angle_to(last_move_direction, Vector3.UP)
	global_rotation.y = lerp_angle(rotation.y, target_angle, rotation_speed * delta)
	pass
	
	$CameraHolder.position = lerp($CameraHolder.position, position, camera_speed * delta)
	
func dash():
	if movement_direction.length() > 0.2:
		movement_speed *= 2.5
		anim_tree.set("parameters/Dash/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		await get_tree().create_timer(.4).timeout
		movement_speed /= 2.5

#-------------------------------------------------------------------------------------------
#              ANIMATION
#-------------------------------------------------------------------------------------------
enum {IDLE, RUN}
var cur_anim = IDLE # Current animation
	
func handle_animations():
	match cur_anim:
		IDLE:
			anim_tree.set("parameters/Movement/transition_request","Idle") 
		RUN:
			anim_tree.set("parameters/Movement/transition_request","Run") 
		
