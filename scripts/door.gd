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

var manager: GameManager

func _ready() -> void:
	manager = get_tree().get_first_node_in_group("GameManager")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		if not is_open:
			if type == lock_type.silver and manager.silver_keys > 0:
				manager.silver_keys -= 1
				is_open = true
				print("Door opened")
				door.queue_free()
			elif type == lock_type.gold and manager.gold_keys > 0:
				manager.gold_keys -= 1
				is_open = true
				print("Door opened")
				door.queue_free()
			elif type == lock_type.normal and manager.keys > 0:
				manager.keys -= 1
				is_open = true
				print("Door opened")
				door.queue_free()
