extends Control

@export var first_level: PackedScene

func _on_play_button_pressed() -> void:
	if first_level:
		get_tree().change_scene_to_packed(first_level)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
