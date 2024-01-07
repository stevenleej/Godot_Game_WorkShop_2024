extends Node2D

class_name Invader_Spawn

const ROWS = 5
const COLUMNS = 11
const V_SPACING = 32
const H_SPACING = 32
const INVADER_HEIGHT = 24
const START_Y_POSITION = -50

const INVADERS_POSITION_X_INCREMENT = 10
const INVADERS_POSITION_Y_INCREMENT = 20

var movement_direction = 1
var invader_scene = preload("res://Scenes/invader_enemy.tscn") # Initialize it here

@onready var movement_timer = $MovementTimer


func _ready():
	movement_timer.timeout.connect(move_invaders)
	
	var invader_1_res = preload("res://Resources/invader_1.tres")
	var invader_2_res = preload("res://Resources/invader_2.tres")
	var invader_3_res = preload("res://Resources/invader_3.tres")

	var invader_config
	for row in range(ROWS):
		if row == 0:
			invader_config = invader_1_res
		elif row == 1 or row == 2:
			invader_config = invader_2_res
		elif row == 3 or row == 4:
			invader_config = invader_3_res
		
		var row_width = (COLUMNS * invader_config.width * 3) + ((COLUMNS - 1) * H_SPACING)
		var start_x_position = (position.x - row_width) / 2

		for col in range(COLUMNS):
			var x = start_x_position + (col * invader_config.width * 3) + (col * H_SPACING)
			var y = START_Y_POSITION + (row * INVADER_HEIGHT) + (row * V_SPACING)
			var spawn_position = Vector2(x, y)
			spawn_invader(invader_config, spawn_position)

# spawn_invader function can now access invader_scene
func spawn_invader(invader_config, spawn_position):
	var invader = invader_scene.instantiate() as Invader_Enemy
	invader.config = invader_config
	invader.global_position = spawn_position
	add_child(invader)

func move_invaders():
	position.x += INVADERS_POSITION_X_INCREMENT * movement_direction

func _on_right_wall_area_entered(area):
	if(movement_direction == 1):
		position.y += INVADERS_POSITION_Y_INCREMENT
		movement_direction *= -1

func _on_left_wall_area_entered(area):
	if(movement_direction == -1):
		position.y += INVADERS_POSITION_Y_INCREMENT 
		movement_direction *= -1
