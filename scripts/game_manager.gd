extends Node
class_name GameManager

@onready var enemy_container: Node = $"../Enemies"
@onready var hud: HUD = $"../HUD"
@onready var podium: Podium = $"../Podium"

var enemies: Array[Node]
var initial_enemy_count
var enemies_clear: bool = false

var silver_keys: int = 0:
	get:
		return silver_keys
	set(value):
		silver_keys = value
		if hud:
			hud.silver_keys_count.text = str(silver_keys).pad_zeros(2)

var gold_keys: int = 0:
	get:
		return gold_keys
	set(value):
		gold_keys = value
		if hud:
			hud.gold_keys_count.text = str(gold_keys).pad_zeros(2)

var keys: int = 0:
	get:
		return keys
	set(value):
		keys = value
		if hud:
			hud.keys_count.text = str(keys).pad_zeros(2)

var enemies_defeated: int = 0:
	get:
		return enemies_defeated
	set(value):
		enemies_defeated = value
		if hud:
			hud.enemies_defeated_count.text = str(enemies_defeated).pad_zeros(2)

func _ready() -> void:
	podium.collision_shape.disabled = true
	
	enemies = enemy_container.get_children()
	initial_enemy_count = enemies.size()
	print("Enemy Count:", initial_enemy_count)

func _process(_delta: float) -> void:
	if enemies_defeated == initial_enemy_count and not enemies_clear:
		enemies_clear = true
		print("All enemies defeated")
		podium.activate()
