extends State
class_name MinionDeath

@onready var skeleton: Enemy = $"../.."
@onready var collider: CollisionShape3D = $"../../CollisionShape3D"

func die():
	skeleton.anim_tree.get("parameters/playback").travel("Death")
	print("I'm ded")
	collider.disabled = true
	await get_tree().create_timer(2).timeout
	skeleton.queue_free()

func Enter():
	die()
