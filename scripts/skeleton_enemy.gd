extends CharacterBody3D
class_name Enemy

@onready var anim_tree: AnimationTree = $AnimationTree
@onready var collider: CollisionShape3D = $CollisionShape3D
@onready var agent: NavigationAgent3D = $NavigationAgent3D
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@export var parts: Array[MeshInstance3D]

@export var health = 6
@export var detection_radius = 17.0
@export var speed = 3.5
@export var attack_range = 2.0

@export var drops: Array[DropData]

var player: Player
var manager: GameManager

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	manager = get_tree().get_first_node_in_group("GameManager")

func _physics_process(_delta: float) -> void:
	if velocity:
		anim_tree.set("parameters/conditions/idle", false)
	else:
		anim_tree.set("parameters/conditions/idle", true)

func _process(_delta: float) -> void:
	if player and player.dead:
		anim_tree.get("parameters/playback").travel("Cheer")

func take_damage(damage: int):
	health -= damage

	if parts:
		for part in parts:
			change_color(part)

func drop_items():
	if drops.size() == 0:
		return
	
	for i in drops.size():
		if drops[i] == null:
			continue
		
		var drop_count: int = drops[i].get_drop_count()
		for j in drop_count:
			var drop = drops[i].item.instantiate()  as Pickup
			add_sibling(drop)
			drop.global_position = global_position + Vector3(randf_range(0, 1.2), 1, randf_range(0, 1.2))
			drop.reparent(get_tree().root)
		pass
	pass

func change_color(part: MeshInstance3D):
	var material = StandardMaterial3D.new()
	material.albedo_color = Color.RED
	
	part.material_override = material # Change to red
	await get_tree().create_timer(0.25).timeout
	part.material_override = null # Change it back to normal
