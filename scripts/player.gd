extends CharacterBody3D

@export_group("Movement")
@export var movement_speed = 8.0
@export var rotation_speed = 12.0
@export var gravity = -30.0
@export var dash_cooldown = 1.0

@onready var camera = %Camera3D
@onready var anim_tree: AnimationTree = $Graphics/Knight/AnimationTree

@export var camera_speed = 10.0

var last_move_direction = Vector3.BACK
var movement_direction:Vector3
var is_dashing: bool = false
var dash_wait = 0


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
	if !is_dashing:
		velocity = movement_direction * movement_speed
	
	velocity.y = y_velocity + gravity * delta
	
	var idle = !movement_direction.length()
	
	anim_tree.set("parameters/conditions/idle", idle)
	anim_tree.set("parameters/conditions/run", !idle)
	anim_tree.set("parameters/conditions/attack", Input.is_action_just_pressed("attack"))
	
	if Input.is_action_just_pressed("dash") and dash_wait <= 0:
		dash()
	else:
		dash_wait -= delta
	
	move_and_slide()
	
	if movement_direction.length() > 0.2:
		last_move_direction = movement_direction
	var target_angle = Vector3.BACK.signed_angle_to(last_move_direction, Vector3.UP)
	if !is_dashing:
		global_rotation.y = lerp_angle(rotation.y, target_angle, rotation_speed * delta)
	
	
	$CameraHolder.position = lerp($CameraHolder.position, position, camera_speed * delta)


func dash():
	if movement_direction.length() > 0.2:
		dash_wait = dash_cooldown
		is_dashing = true
		velocity = last_move_direction.normalized() * 40
		anim_tree.set("parameters/conditions/dash", true)
		await get_tree().create_timer(.2).timeout
		anim_tree.set("parameters/conditions/dash", false)
		is_dashing = false
