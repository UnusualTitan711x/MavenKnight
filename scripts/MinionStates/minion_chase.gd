extends State
class_name MinionChase

var player: Player
@onready var agent: NavigationAgent3D = $"../../NavigationAgent3D"
@onready var skeleton: Enemy = $"../.."

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func PhysicsUpdate(delta: float):
	agent.target_position = player.global_position
	var direction = Vector3()
	direction = agent.get_next_path_position() - skeleton.global_position
	direction.normalized()
	
	skeleton.velocity = direction * skeleton.speed
	
	skeleton.look_at(player.global_position, Vector3.UP)
	skeleton.rotation.z = 0
	skeleton.rotation.x = 0
	
	skeleton.move_and_slide()
	
	var distance_to_player = skeleton.global_position - player.global_position
	
	if distance_to_player.length() > skeleton.detection_radius:
		transitioned.emit(self, "MinionIdle")

func Update(_delta: float):
	if skeleton.health <= 0:
		transitioned.emit(self, "MinionDeath")
