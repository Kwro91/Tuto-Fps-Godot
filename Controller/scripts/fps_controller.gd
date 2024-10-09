extends CharacterBody3D

@export var SPEED : float = 5.0
@export var SPEED_CROUCH : float = 2.0
@export var JUMP_VELOCITY : float = 4.5

#pour la camera :
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var CAMERA_CONTROLLER : Camera3D
@export var SENSITIVITY : float = 0.3
#pour les animations :
@export var ANIMATIONPLAYER : AnimationPlayer
#Crouch
@export_range(5, 10, 0.1) var CROUCH_SPEED : float = 7.0 #Ca nous sert pour modifier la vitesse de crouch de 5-10 avec 7*vitesse par defaut
@export var CROUCH_SHAPECAST : Node3D
@export var TOGGLE_CROUCH : bool = false #false = hold | true = press

var _speed : float
#si la souris bouge ou non :
var	_mouse_input : bool = false
var	_mouse_rotation : Vector3
var	_rotation_input : float
var	_tilt_input : float
#crouch
var _is_crouching : bool = false

func _input(event):
	if(event.is_action_pressed("exit")):
		get_tree().quit()
	if event.is_action_pressed("crouch") and TOGGLE_CROUCH == true:
		_toggle_crouch()
	if event.is_action_pressed("crouch") and _is_crouching ==false and TOGGLE_CROUCH == false: #Hold to crouch
		_crouching(true)
	if event.is_action_released("crouch") and TOGGLE_CROUCH == false: #Release to Uncrouch
		if CROUCH_SHAPECAST.is_colliding() == false:
			_crouching(false)

func _unhandled_input(event):
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x
		_tilt_input = -event.relative.y
		#print(Vector2(_rotation_input,_tilt_input))

func _update_camera(delta): #delta = toute les frames
	
	#Rotate camera using euler rotation
	_mouse_rotation.x += _tilt_input * SENSITIVITY * delta #on deplace la camera en fct de la force de rotation x et des frames 
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * SENSITIVITY * delta #meme raisonnement ici sauf que c'est l'axe y
	
	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_mouse_rotation) #Ici on prends en charge la rotation de la camera
	CAMERA_CONTROLLER.rotation.z = 0.0
	# Ensuite on reset la force de rotation des deux axes
	_rotation_input = 0.0
	_tilt_input = 0.0
	
func _handle_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func _set_movement_speed(state : bool): #On donne la valeur de _is_crouching ici
	match state:
		true:
			_speed = SPEED_CROUCH
		false:
			_speed = SPEED


func _handle_movements(delta):
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor() and _is_crouching == false:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")

		# Prendre en compte uniquement les axes X et Z de la caméra pour les déplacements
	var forward := CAMERA_CONTROLLER.transform.basis.z.normalized()
	var side := CAMERA_CONTROLLER.transform.basis.x.normalized()

	var direction := (side * input_dir.x) + (forward * input_dir.y)
	direction = direction.normalized()
	
	_set_movement_speed(_is_crouching)
	
	if direction.length() > 0:
		velocity.x = direction.x * _speed
		velocity.z = direction.z * _speed
	else:
		velocity.x = 0
		velocity.z = 0
	translate(velocity * delta)

func _ready(): #se lance au depart
	#Capturer la souris
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#Eviter de checker les collisions shapecast avec celles des noeuds de ce characterbody3d
	CROUCH_SHAPECAST.add_exception($".")

func _toggle_crouch():
	if _is_crouching == true and CROUCH_SHAPECAST.is_colliding() == false: #UNCROUCH
		_crouching(false)
	elif _is_crouching == false: #CROUCH
		_crouching(true)

func _crouching(state : bool):
	match state:
		true:
			ANIMATIONPLAYER.play("crouch", 0, CROUCH_SPEED)
		false:
			ANIMATIONPLAYER.play("crouch", 0, -CROUCH_SPEED, true)

func _on_animation_player_animation_started(anim_name: StringName) -> void: #Se declenche lors d'un debut d'animation
	if anim_name == "crouch":
		_is_crouching = !_is_crouching

func _handle_auto_uncrouch(delta): #sert a se uncrouch tout seul si le crouch a ete release en dessous de qqch
	if !Input.is_action_pressed("crouch") and _is_crouching == true and CROUCH_SHAPECAST.is_colliding() == false and TOGGLE_CROUCH == false: #Release to Uncrouch
		_crouching(false)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	_handle_gravity(delta)
	_update_camera(delta)
	_handle_movements(delta)
	if _is_crouching == true: #verifie que le joueur est crouch pour eviter les instructions inutiles
		_handle_auto_uncrouch(delta)
	move_and_slide() #Fct godot qui gere les collisions des box godot
