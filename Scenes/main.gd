extends Node

class_name MainGameStates
@export var GameOverSprite = Node2D


func CheckWinCondition() -> void:
	if 	find_child("Player").playerScore >= 55:
		find_child("Player").isWin = true
		$GameWin.visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("end_game"):
		get_tree().change_scene_to_file("res://Scenes/GameStart.tscn")
	
	# Check if game is won
	CheckWinCondition()
	

