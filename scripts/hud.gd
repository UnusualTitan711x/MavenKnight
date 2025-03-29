extends Control
class_name HUD

@onready var health_bar: ProgressBar = $HealthBar
@onready var stamina_bar: ProgressBar = $StaminaBar
@onready var enemies_killed_count: Label = $enemies_killed_count
@onready var keys_count: Label = $keys_count

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	health_bar.max_value = player.max_health
	stamina_bar.max_value = player.max_stamina
	enemies_killed_count.text = str(player.enemies_defeated)
	keys_count.text = str(player.keys)

func _process(delta: float) -> void:
	health_bar.value = player.health
	stamina_bar.value = player.stamina
