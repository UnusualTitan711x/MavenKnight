extends Control
class_name HUD

@onready var health_bar: ProgressBar = $HealthBar
@onready var stamina_bar: ProgressBar = $StaminaBar
@onready var enemies_defeated_count: Label = $enemies_killed_count
@onready var keys_count: Label = $keys_count
@onready var silver_keys_count: Label = $silver_keys_count
@onready var gold_keys_count: Label = $gold_keys_count

var player: Player
var manager: GameManager

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	manager = get_tree().get_first_node_in_group("GameManager")
	
	health_bar.max_value = player.max_health
	stamina_bar.max_value = player.max_stamina
	enemies_defeated_count.text = str(manager.enemies_defeated)
	keys_count.text = str(manager.keys)
	silver_keys_count.text = str(manager.silver_keys)
	gold_keys_count.text = str(manager.gold_keys)

func _process(_delta: float) -> void:
	health_bar.value = player.health
	stamina_bar.value = player.stamina
