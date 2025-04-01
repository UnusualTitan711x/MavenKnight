extends Node3D
class_name Podium

@onready var collision_shape: CollisionShape3D = $Area3D/CollisionShape3D

var enemies: Array
var initial_enemy_count: int
var enemies_clear: bool = false
var manager: GameManager



func activate():
	collision_shape.disabled = false
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		get_tree().reload_current_scene()
