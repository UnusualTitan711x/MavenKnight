extends Control

@onready var health_bar: ProgressBar = $HealthBar
@onready var stamina_bar: ProgressBar = $StaminaBar

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	health_bar.max_value = player.max_health
	stamina_bar.max_value = player.max_stamina

func _process(delta: float) -> void:
	health_bar.value = player.health
	stamina_bar.value = player.stamina
