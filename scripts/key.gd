extends Pickup

@export var type: lock_type = lock_type.normal

enum lock_type {
	normal,
	silver,
	gold
}


func on_item_picked():
	if type == lock_type.silver:
		manager.silver_keys += 1
	if type == lock_type.gold:
		manager.gold_keys += 1
	elif type == lock_type.normal:
		manager.keys += 1
	print("Key added")
	queue_free()
