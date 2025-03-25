extends Area3D



func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.keys += 1
		print("Key added")
		# do something
		queue_free()
