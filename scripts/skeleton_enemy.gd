extends Node3D
class_name Enemy

@onready var anim_tree: AnimationTree = $AnimationTree
@export var health = 6

func take_damage(damage: int):
	if health <= damage:
		die()
		return
	
	print("ouch!")
	health -= damage
	anim_tree.get("parameters/playback").travel("Hit")

func die():
	anim_tree.get("parameters/playback").travel("Death")
	print("I'm ded")
	await get_tree().create_timer(2).timeout
	queue_free()
