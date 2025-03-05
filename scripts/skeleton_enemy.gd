extends CharacterBody3D
class_name Enemy

@onready var anim_tree: AnimationTree = $AnimationTree
@onready var collider: CollisionShape3D = $CollisionShape3D
@onready var agent: NavigationAgent3D = $NavigationAgent3D


@export var health = 6
@export var detection_radius = 10.0
@export var speed = 3.5

func take_damage(damage: int):
	print("ouch!")
	health -= damage
	anim_tree.get("parameters/playback").travel("Hit")
