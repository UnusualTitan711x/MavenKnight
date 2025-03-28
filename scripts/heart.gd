extends Area3D

@export var health_amount = 3

func _on_body_entered(body: Node3D) -> void:
    if body is Player:
        if body.health < body.max_health:
            body.health = clamp(body.health + health_amount, 0, body.max_health)
            print("Health++")
            queue_free()
