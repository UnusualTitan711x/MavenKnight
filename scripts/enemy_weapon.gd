extends Area3D
class_name EnemyWeapon

@export var damage = 5

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		print("ouch!")
		body.take_damage(damage)
