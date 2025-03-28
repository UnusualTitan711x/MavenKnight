extends Node3D

@onready var door: StaticBody3D = $door
@export var locked = false
var is_open: bool = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		if body.keys > 0 and not is_open:
			body.keys -= 1
			is_open = true
			print("Door opened")
			door.queue_free()
