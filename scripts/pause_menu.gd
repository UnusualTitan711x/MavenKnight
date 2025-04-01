extends Control

var manager: GameManager

func _ready() -> void:
	manager = get_tree().get_first_node_in_group("GameManager")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_resume_button_pressed() -> void:
	manager.resume_game()
