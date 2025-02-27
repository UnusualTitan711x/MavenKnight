extends Node3D
class_name Weapon

func _on_body_entered(body: Node3D) -> void:
	if body is Enemy:
		body.take_damage()
