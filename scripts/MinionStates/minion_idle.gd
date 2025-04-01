extends State
class_name MinionIdle

@onready var skeleton: Enemy = $"../.."

var player: Player

func Enter():
	if skeleton.anim_tree:
		skeleton.anim_tree.set("parameters/conditions/idle", true)
	
	player = get_tree().get_first_node_in_group("Player")

func Update(_delta: float):
	if skeleton.health <= 0:
		transitioned.emit(self, "MinionDeath")

func PhysicsUpdate(_delta: float):
	var distance_to_player = skeleton.global_position - player.global_position
	
	if distance_to_player.length() <= skeleton.attack_range:
		transitioned.emit(self, "MinionAttack")
	
	if distance_to_player.length() <= skeleton.detection_radius:
		transitioned.emit(self, "MinionChase")
	
	

func Exit():
	skeleton.anim_tree.set("parameters/conditions/idle", false)
