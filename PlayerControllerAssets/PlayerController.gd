extends CharacterBody2D

@export var speed = 400
@export var playerSprite = Node2D
@export var direction : Vector2 = Vector2(0,0)
@export var canShoot = true
@export var mainSceneNode = Node2D
@export var isDead = false
@export var isWin = false

var laserBullet = preload("res://PlayerControllerAssets/PlayerGunLaser.tscn")
var playerScore = 0


func CheckIsMoving() -> void:
	if direction.x > 0:
		# play the animation
		playerSprite.PlayLeftAnimation()
	elif direction.x < 0:
		playerSprite.PlayRightAnimation()
	else:
		playerSprite.PlayIdleAnimation()

func Explode() -> void:
	isDead = true
	print_debug("method called")
	playerSprite.PlayDeadAnimation()
	#wait for animation to end  https://forum.godotengine.org/t/how-can-i-use-await-to-wait-just-a-few-seconds-without-needing-a-signal-to-be-activated-to-just-delay-code-execution/1502/2
	await get_tree().create_timer(1).timeout
	get_parent().get_node("GameOver").visible = true
	queue_free()

func Shoot() -> void:
	if Input.is_action_just_released("shoot_ray_1") && canShoot: 
		print_debug("shot a bullet")
		canShoot = false
		var bulletClone = laserBullet.instantiate()
		get_tree().get_root().add_child(bulletClone)
		bulletClone.global_position = %GunEntryPoint.global_position

func _init():
	# set initial values at start of instantiation
	isDead = false
	isWin = false
	playerScore = 0 
		
func _ready():
	print_debug("hello world!")
	
func _physics_process(delta):
	if !isDead && !isWin: 
		# At the moment, let the player not move up or down. get vector requies all four inputs normally.
		# direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		direction = Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
		velocity = direction * speed 
		CheckIsMoving()
		move_and_slide()
		Shoot()

# Created with the Timer node -> we attached a Signal (see observer pattern reference) to define an event on what should
# happen after the timer deadline we set is reached.

func _on_bullet_cool_down_timeout():
	if !canShoot:
		canShoot = true


