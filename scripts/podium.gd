extends Node3D
class_name Podium

@onready var collision_shape: CollisionShape3D = $Area3D/CollisionShape3D
@onready var cylinder: MeshInstance3D = $CSGBakedMeshInstance3D/MeshInstance3D

@export var next_level: PackedScene

var enemies: Array
var initial_enemy_count: int
var enemies_clear: bool = false
var manager: GameManager



func activate():
	collision_shape.disabled = false
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		# 
		if next_level:
			get_tree().change_scene_to_packed(next_level)
		else:
			get_tree().reload_current_scene()
