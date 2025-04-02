extends State
class_name MinionAttack

@onready var skeleton: Enemy = $"../.."
var cooldown = 1.5
var time_since_last_attack = 0.0

var player: Player

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	attack()
	#skeleton.anim_tree.set("parameters/conditions/attack", true)

func Exit():
	#skeleton.anim_tree.set("parameters/conditions/attack", false)
	pass
	
func Update(delta: float):
	time_since_last_attack += delta
	
	var direction = skeleton.global_position.direction_to(player.global_position)
	direction.y = 0
	var target_basis = Basis().looking_at(direction, Vector3.UP)
	skeleton.global_transform.basis = skeleton.global_transform.basis.slerp(target_basis, 10 * delta)

	if skeleton.global_position.distance_to(player.global_position) > skeleton.attack_range and not skeleton.anim_player.is_playing():
		transitioned.emit(self, "MinionIdle")
	else:
		if time_since_last_attack >= cooldown:
			time_since_last_attack = 0.0
			attack()
			transitioned.emit(self, "MinionIdle")
	
	if skeleton.health <= 0:
		transitioned.emit(self, "MinionDeath")

func attack():
	skeleton.anim_tree.get("parameters/playback").travel("Attack")
