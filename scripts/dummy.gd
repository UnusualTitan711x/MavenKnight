extends Node3D
class_name Dummy

@export var health = 3
@export var parts: Array[MeshInstance3D]

func take_damage(damage: int):
	if health <= damage:
		die()
		return
	
	print("ouch!")
	health -= damage
	
	var material = StandardMaterial3D.new()
	material.albedo_color = Color.RED
	
	if parts:
		for part in parts:
			change_color(part)
			

func change_color(part: MeshInstance3D):
	var material = StandardMaterial3D.new()
	material.albedo_color = Color.RED
	
	part.material_override = material # Change to red
	await get_tree().create_timer(0.25).timeout
	part.material_override = null # Change it back to normal

func die():
	queue_free()
