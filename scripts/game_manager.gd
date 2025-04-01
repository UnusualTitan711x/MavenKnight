extends Node
class_name GameManager

@onready var enemy_container: Node = $"../Enemies"
@onready var hud: HUD = $"../HUD"

var silver_keys: int = 0
var gold_keys: int = 0
var keys: int = 0:
	get:
		return keys
	set(value):
		keys = value
		print(keys)
		if hud:
			hud.keys_count.text = str(keys)

var enemies_defeated: int = 0:
	get:
		return enemies_defeated
	set(value):
		enemies_defeated = value
		if hud:
			hud.enemies_defeated_count.text = str(enemies_defeated)
