extends State
class_name MinionAttack

@onready var skeleton: Enemy = $"../.."

var player: Player

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	skeleton.anim_tree.set("parameters/conditions/attack", true)

func Exit():
	skeleton.anim_tree.set("parameters/conditions/attack", false)
	
func Update(_delta: float):
	var distance_to_player = skeleton.global_position.distance_to(player.global_position)
	
	skeleton.look_at(player.global_position, Vector3.UP)
	
	if skeleton.global_position.distance_to(player.global_position) > skeleton.attack_range:
		transitioned.emit(self, "MinionIdle")
	
	if skeleton.health <= 0:
		transitioned.emit(self, "MinionDeath")
	
