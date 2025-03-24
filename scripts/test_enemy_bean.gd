extends Node3D
class_name Test_Enemy

@onready var mesh = $MeshInstance3D
@export var health = 6

func take_damage(damage: int):
	if health <= damage:
		die()
		return
	
	print("ouch!")
	health -= damage
	
	var material = StandardMaterial3D.new()
	
	material.albedo_color = Color.RED
	mesh.material_override = material # Change color to red
	await get_tree().create_timer(0.25).timeout
	material.albedo_color = Color.WHITE
	mesh.material_override = null # Change it back to white

func die():
	print("I'm ded")
	queue_free()
