extends Pickup

@export var health_amount = 3

func on_item_picked():
	if player.health < player.max_health:
		player.health = clamp(player.health + health_amount, 0, player.max_health)
		print("Health++")
		queue_free()
