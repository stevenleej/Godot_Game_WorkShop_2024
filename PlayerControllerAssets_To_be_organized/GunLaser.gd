extends Area2D


@export var projectileSpeed  = 300
@export var range = 1200

@export var bullet_direction : Vector2 = Vector2(0,0) 
@export var bullet_range = 0

func checkTravelExpiry(range):
	if bullet_range > range:
		queue_free()

func _physics_process(delta):
	bullet_direction = Vector2.UP
	position += bullet_direction * projectileSpeed * delta
	bullet_range += projectileSpeed * delta
	#check for travel range and then expire
	checkTravelExpiry(bullet_range)

func _on_body_entered(body):
	#delete the entity
	queue_free()
	# 1 frame before lifecycle event ends
	# check if a given code entity has some property or function
	if body.has_method("take_damage"):
		body.take_damage()
