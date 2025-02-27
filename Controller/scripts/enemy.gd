extends CharacterBody3D

var HEALTH = 50

func _ready():
	add_to_group("Enemy")


func _physics_process(delta: float) -> void:
	if (HEALTH <= 0):
		queue_free()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
