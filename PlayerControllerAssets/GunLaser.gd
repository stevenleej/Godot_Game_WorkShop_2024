extends Area2D

class_name Laser
@export var projectileSpeed  = 500
@export var range = 1200

@export var bullet_direction : Vector2 = Vector2(0,0) 
@export var bullet_range = 0

func checkTravelExpiry(range):
	if bullet_range > range:
		queue_free()

func _physics_process(delta):
	position.y -= projectileSpeed * delta
	bullet_range += projectileSpeed * delta
	#check for travel range and then expire
	checkTravelExpiry(bullet_range)

# interacts with Physics based collisions (ex: player body 2d)
func _on_body_entered(body):
	#delete the entity
	queue_free()
	# 1 frame before lifecycle event ends
	# check if a given code entity has some property or function
	if body.has_method("take_damage"):
		body.TakeDamage()

# interacts with Area2D collisions
func _on_area_entered(area):
		#delete the entity
		print_debug(area)
		get_parent().get_child(0).find_child("Player").playerScore += 1
		print_debug(get_parent().get_child(0).find_child("Player").playerScore)
		area.queue_free()
		queue_free()
