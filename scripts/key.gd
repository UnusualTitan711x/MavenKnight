extends Pickup

func on_item_picked():
	player.keys += 1
	print("Key added")
	queue_free()
