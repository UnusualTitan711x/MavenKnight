extends Control

@export var start_creen: PackedScene

func _on_replay_button_pressed() -> void:
	get_tree().change_scene_to_packed(start_creen)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
