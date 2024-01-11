extends Area2D
class_name Invader_Enemy

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
var config: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = config.sprite
	animation_player.play(config.animation_name)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroy":
		queue_free()



func _on_body_entered(body):
	if body.get_collision_layer() == 1:
		print_debug("player collided")
		body.Explode()

