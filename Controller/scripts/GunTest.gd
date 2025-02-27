extends Node3D

@export var DAMAGE : int = 10
@export var FIRE_RATE : float = 0.2
@export var ANIMATION_GUN : AnimationPlayer
@export var CAMERA : Camera3D
@export var RAYCAST : RayCast3D

var target

func _fire():
	if (Input.is_action_pressed("left_click")):
		if not (ANIMATION_GUN.is_playing()):
			if (RAYCAST.is_colliding()):
				target = RAYCAST.get_collider()
				if target && target.is_in_group("Enemy"):
					target.HEALTH -= DAMAGE
					print("Hit")
			#print("fire a shot") 
		ANIMATION_GUN.play("FireAnim", 0)
	else:
		ANIMATION_GUN.stop()
