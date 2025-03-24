extends Area3D
class_name PlayerWeapon

@export var damage = 1

func _on_body_entered(body: Node3D) -> void:
	if body is Dummy or Test_Enemy or Enemy:
		body.take_damage(damage)
	
