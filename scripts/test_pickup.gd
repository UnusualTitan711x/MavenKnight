extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		print("Item Picked")
		# do something
		queue_free()
