extends Node3D

@export var enemy_container: Node
@onready var collision_shape: CollisionShape3D = $Area3D/CollisionShape3D

var enemies: Array
var initial_enemy_count: int
var enemies_clear: bool = false
var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	
	collision_shape.disabled = true
	
	if enemy_container:
		enemies = enemy_container.get_children()
		initial_enemy_count = enemies.size()
		print("Enemy Count:", initial_enemy_count)

func _process(_delta: float) -> void:
	if player.enemies_defeated == initial_enemy_count and not enemies_clear:
		enemies_clear = true
		print("All enemies defeated")
		collision_shape.disabled = false
		return

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		get_tree().reload_current_scene()
