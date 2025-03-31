extends Node3D

@onready var door: StaticBody3D = $door
@export var locked = false
@export var type: lock_type = lock_type.normal
var is_open: bool = false

enum lock_type {
	normal,
	silver,
	gold
}

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		if not is_open:
			if type == lock_type.silver and body.silver_keys > 0:
				body.silver_keys -= 1
				is_open = true
				print("Door opened")
				door.queue_free()
			elif type == lock_type.gold and body.gold_keys > 0:
				body.gold_keys -= 1
				is_open = true
				print("Door opened")
				door.queue_free()
			elif type == lock_type.normal and body.keys > 0:
				body.keys -= 1
				is_open = true
				print("Door opened")
				door.queue_free()
