extends Control


func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")



func _on_exit_game_pressed():
	get_tree().quit()
