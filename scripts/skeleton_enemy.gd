extends CharacterBody3D
class_name Enemy

@onready var anim_tree: AnimationTree = $AnimationTree
@onready var collider: CollisionShape3D = $CollisionShape3D
@onready var agent: NavigationAgent3D = $NavigationAgent3D


@export var health = 6
@export var detection_radius = 17.0
@export var speed = 3.5
@export var attack_range = 2.0

var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta: float) -> void:
	if velocity:
		anim_tree.set("parameters/conditions/idle", false)
	else:
		anim_tree.set("parameters/conditions/idle", true)

func _process(delta: float) -> void:
	if player.dead:
		anim_tree.get("parameters/playback").travel("Cheer")

func take_damage(damage: int):
	health -= damage
	anim_tree.get("parameters/playback").travel("Hit")
