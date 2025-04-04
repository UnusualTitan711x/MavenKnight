extends State
class_name MinionDeath

const PICKUP = preload("res://scenes/heart.tscn")

@onready var skeleton: Enemy = $"../.."
@onready var collider: CollisionShape3D = $"../../CollisionShape3D"

@export_category("Item drops")

func die():
	skeleton.anim_tree.get("parameters/playback").travel("Death")
	print("I'm ded")
	skeleton.manager.play_sound("skeleton_die")
	collider.disabled = true
	await get_tree().create_timer(2).timeout
	skeleton.queue_free()

func Enter():
	if skeleton.manager:
		skeleton.manager.enemies_defeated += 1
	skeleton.drop_items()
	die()
