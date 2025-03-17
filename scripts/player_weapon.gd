extends Area3D
class_name PlayerWeapon

@export var damage = 1

func _on_body_entered(body: Node3D) -> void:
	if body is Enemy or body is Test_Enemy:
		body.take_damage(damage)
