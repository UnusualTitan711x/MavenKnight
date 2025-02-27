extends Node3D
class_name Enemy

@onready var mesh = $MeshInstance3D

func take_damage():
	var material = StandardMaterial3D.new()
	material.albedo_color = Color.RED
	mesh.material_override = material
	print("ouch!")
	await get_tree().create_timer(0.25).timeout
	material.albedo_color = Color.WHITE
	mesh.material_override = material
