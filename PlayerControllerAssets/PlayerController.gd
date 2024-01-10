extends CharacterBody2D

@export var speed = 400
@export var playerSprite = Node2D
@export var direction : Vector2 = Vector2(0,0)
@export var health = 100.0
@export var canShoot = true
@export var mainSceneNode = Node2D

var laserBullet = preload("res://PlayerControllerAssets/PlayerGunLaser.tscn")

#we connect these to a signal in  the Node menu	
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
		print_debug("tt")
		canShoot = false
		var bulletClone = laserBullet.instantiate()
		get_tree().get_root().add_child(bulletClone)
		bulletClone.global_position = %GunEntryPoint.global_position

func _init():
	pass
		
func _ready():
	print_debug("hello world!")

func _physics_process(delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed 
	CheckIsMoving()
	move_and_slide()
	Shoot()

# Created with the Timer node -> we attached a Signal (see observer pattern reference) to define an event on what should
# happen after the timer deadline we set is reached.

func _on_bullet_cool_down_timeout():
	if !canShoot:
		canShoot = true

