extends Node2D

@export var AnimatorPlayer = AnimationPlayer

#this function manages the animations of the player as form of events 
func PlayIdleAnimation() -> void:
	%AnimationPlayer.play("idle")


func PlayLeftAnimation() -> void:
	%AnimationPlayer.play("left")


func PlayRightAnimation() -> void:
	%AnimationPlayer.play("right")