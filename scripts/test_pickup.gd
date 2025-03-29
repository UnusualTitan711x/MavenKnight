extends Area3D
class_name Pickup

var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		on_item_picked()
		queue_free()

func on_item_picked():
	pass
