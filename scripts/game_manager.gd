extends Node
class_name GameManager

@onready var enemy_container: Node = $"../Enemies"
@onready var podium: Podium = $"../Podium"
@onready var pause_menu: Control = $"../UI Layer/PauseMenu"
@onready var hud: HUD = $"../UI Layer/HUD"
@onready var death_screen: Control = $"../UI Layer/DeathScreen"
@onready var heart_pickup_sfx: AudioStreamPlayer = $"../Sounds/HeartPickupSFX"

var player: Player
var enemies: Array[Node]
var initial_enemy_count
var enemies_clear: bool = false
var paused: bool = false
var can_pause: bool = true

var silver_keys: int = 0:
	set(value):
		silver_keys = value
		if hud:
			hud.silver_keys_count.text = str(silver_keys)

var gold_keys: int = 0:
	set(value):
		gold_keys = value
		if hud:
			hud.gold_keys_count.text = str(gold_keys)

var keys: int = 0:
	set(value):
		keys = value
		if hud:
			hud.keys_count.text = str(keys)

var enemies_defeated: int = 0:
	get:
		return enemies_defeated
	set(value):
		enemies_defeated = value
		if hud:
			hud.enemies_defeated_count.text = str(enemies_defeated)

func _ready() -> void:
	can_pause = true
	player = get_tree().get_first_node_in_group("Player")
	enemies = enemy_container.get_children()
	initial_enemy_count = enemies.size()
	print("Enemy Count:", initial_enemy_count)
	resume_game()

func _process(_delta: float) -> void:
	if enemies_defeated == initial_enemy_count and not enemies_clear:
		enemies_clear = true
		print("All enemies defeated")
		podium.activate()
	
	if Input.is_action_just_pressed("pause") and can_pause:
		if paused:
			resume_game()
		else:
			pause_game()
	
	if player.dead == true:
		can_pause = false
		death_screen.show()

func pause_game():
	get_tree().paused = true
	paused = true
	pause_menu.show()

func resume_game():
	get_tree().paused = false
	paused = false
	pause_menu.hide()

func play_sound(name: String):
	if name == "heart":
		$"../Sounds/HeartPickupSFX".play()
	elif name == "key":
		$"../Sounds/KeyPickupSFX".play()
	elif name == "man_hurt":
		$"../Sounds/ManHurt".play()
	elif name == "skeleton_hurt":
		$"../Sounds/SkeletonHurt".play()
	elif name == "player_die":
		$"../Sounds/PlayerDie".play()
	elif name == "skeleton_die":
		$"../Sounds/SkeletonDie".play()
