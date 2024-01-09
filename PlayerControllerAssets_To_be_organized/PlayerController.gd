extends CharacterBody2D

@export var speed = 400
@export var playerSprite = Node2D
@export var direction : Vector2 = Vector2(0,0)
@export var health = 100.0
@export var canShoot = true

var laserBullet

signal healthDepleted

func TakeDamage() -> void:
	if health > 0:
		health -= 10

func CheckIsMoving() -> void:
	if direction.x > 0:
		# play the animation
		playerSprite.PlayLeftAnimation()
	elif direction.x < 0:
		playerSprite.PlayRightAnimation()
	else:
		playerSprite.PlayIdleAnimation()

func Shoot() -> void:
	if Input.is_action_just_released("shoot_ray_1") && canShoot: 
		canShoot = false
		print_debug("i shot something")
		laserBullet = preload("res://PlayerControllerAssets_To_be_organized/PlayerGunLaser.tscn")
		var new_bullet = laserBullet.instantiate()
		# instantiate bullet at the position of the new bullet object
		new_bullet.global_position = %GunEntryPoint.position
		#shoot_point.add_child(new_bullet)
		%GunEntryPoint.add_child(new_bullet)

func _init():
	pass
		
func _ready():
	print_debug("hello world!")
	

func _physics_process(delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed 
	CheckIsMoving()
	move_and_slide()


func _process(delta):
	Shoot()

# Created with the Timer node -> we attached a Signal (see observer pattern reference) to define an event on what should
# happen after the timer deadline we set is reached.

func _on_bullet_cool_down_timeout():
	if !canShoot:
		canShoot = true
