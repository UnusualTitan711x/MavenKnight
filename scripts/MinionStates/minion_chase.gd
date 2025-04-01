extends State
class_name MinionChase

var player: Player
@onready var agent: NavigationAgent3D = $"../../NavigationAgent3D"
@onready var skeleton: Enemy = $"../.."

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func PhysicsUpdate(_delta: float):
	agent.target_position = player.global_position
	if player.dead:
		transitioned.emit(self, "MinionIdle")
	
	if not agent.is_navigation_finished():
		var direction = skeleton.global_position.direction_to(agent.get_next_path_position())
		skeleton.velocity = direction * skeleton.speed
		skeleton.anim_tree.set("parameters/conditions/run", true)
		skeleton.move_and_slide()
	else:
		transitioned.emit(self, "MinionIdle")
	
	skeleton.look_at(agent.get_next_path_position(), Vector3.UP)
	
	if skeleton.global_position.distance_to(player.global_position) > skeleton.detection_radius * 2:
		transitioned.emit(self, "MinionIdle")

func Update(_delta: float):
	if skeleton.health <= 0:
		transitioned.emit(self, "MinionDeath")
	

func Exit():
	skeleton.anim_tree.set("parameters/conditions/run", false)
