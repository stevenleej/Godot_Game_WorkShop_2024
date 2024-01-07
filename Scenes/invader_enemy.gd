extends Area2D
class_name Invader_Enemy

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
var config: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = config.sprite
	animation_player.play(config.animation_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
