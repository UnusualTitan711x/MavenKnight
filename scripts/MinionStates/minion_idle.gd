extends State
class_name MinionIdle

@onready var skeleton: Enemy = $"../.."

var player: Player

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Update(_delta: float):
	if skeleton.health <= 0:
		transitioned.emit(self, "MinionDeath")

func PhysicsUpdate(delta: float):
	var distance_to_player = skeleton.global_position - player.global_position
	
	if distance_to_player.length() <= skeleton.detection_radius:
		transitioned.emit(self, "MinionChase")
