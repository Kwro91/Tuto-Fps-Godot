extends CenterContainer

@export var DOT_RADIUS : float = 2.0
@export var DOT_COLOR : Color = Color.RED

@export var PLAYER_CONTROLLER : CharacterBody3D
@export var LINE_TOP : Line2D
@export var LINE_BOT : Line2D
@export var LINE_RIGHT : Line2D
@export var LINE_LEFT : Line2D

@export var DOT_DISTANCE : float = 8.0
@export var LINE_LENGHT_TB : float = 8.0
@export var LINE_LENGHT_LR : float = 15.0
@export var LINE_WIDTH = 2

var _TopStart = Vector2(0.0, DOT_DISTANCE)
var _TopEnd = Vector2(0.0, DOT_DISTANCE + LINE_LENGHT_TB)

var _BotStart = Vector2(0.0, -DOT_DISTANCE)
var _BotEnd = Vector2(0.0, -DOT_DISTANCE - LINE_LENGHT_TB)

var _RightStart = Vector2(DOT_DISTANCE, 0.0)
var _RightEnd = Vector2(DOT_DISTANCE + LINE_LENGHT_LR, 0.0)

var _LeftStart = Vector2(-DOT_DISTANCE, 0.0)
var _LeftEnd = Vector2(-DOT_DISTANCE - LINE_LENGHT_LR, 0.0)

func _set_var():
	_TopStart = Vector2(0.0, DOT_DISTANCE)
	_TopEnd = Vector2(0.0, DOT_DISTANCE + LINE_LENGHT_TB)

	_BotStart = Vector2(0.0, -DOT_DISTANCE)
	_BotEnd = Vector2(0.0, -DOT_DISTANCE - LINE_LENGHT_TB)

	_RightStart = Vector2(DOT_DISTANCE, 0.0)
	_RightEnd = Vector2(DOT_DISTANCE + LINE_LENGHT_LR, 0.0)

	_LeftStart = Vector2(-DOT_DISTANCE, 0.0)
	_LeftEnd = Vector2(-DOT_DISTANCE - LINE_LENGHT_LR, 0.0)

func _draw_lines():
	_set_var()
	#Handle Color
	LINE_TOP.default_color = DOT_COLOR
	LINE_BOT.default_color = DOT_COLOR
	LINE_RIGHT.default_color = DOT_COLOR
	LINE_LEFT.default_color = DOT_COLOR
	#Handle Line
	LINE_TOP.add_point(_TopStart)
	LINE_TOP.add_point(_TopEnd)
	LINE_BOT.add_point(_BotStart)
	LINE_BOT.add_point(_BotEnd)
	LINE_RIGHT.add_point(_RightStart)
	LINE_RIGHT.add_point(_RightEnd)
	LINE_LEFT.add_point(_LeftStart)
	LINE_LEFT.add_point(_LeftEnd)
	#Handle Line Width
	LINE_TOP.width = LINE_WIDTH
	LINE_BOT.width = LINE_WIDTH
	LINE_RIGHT.width = LINE_WIDTH
	LINE_LEFT.width = LINE_WIDTH

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw() #redraw any draw in the script


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw():
	draw_circle(Vector2(0,0), DOT_RADIUS, DOT_COLOR) #draw reticle dot
	_draw_lines()
