extends CenterContainer

@export var DOT_RADIUS : float = 2.0
@export var DOT_COLOR : Color = Color.RED

@export var LineTop : Line2D
@export var LineBot : Line2D
@export var LineRight : Line2D
@export var LineLeft : Line2D

@export var DOT_DISTANCE : float = 10.0
@export var LINE_LENGHT : float = 15.0
@export var LINE_WIDTH = 2

var _TopStart = Vector2(0.0, DOT_DISTANCE)
var _TopEnd = Vector2(0.0, DOT_DISTANCE + LINE_LENGHT)

var _BotStart = Vector2(0.0, -DOT_DISTANCE)
var _BotEnd = Vector2(0.0, -DOT_DISTANCE - LINE_LENGHT)

var _RightStart = Vector2(DOT_DISTANCE, 0.0)
var _RightEnd = Vector2(DOT_DISTANCE + LINE_LENGHT, 0.0)

var _LeftStart = Vector2(-DOT_DISTANCE, 0.0)
var _LeftEnd = Vector2(-DOT_DISTANCE - LINE_LENGHT, 0.0)

func _set_var():
	_TopStart = Vector2(0.0, DOT_DISTANCE)
	_TopEnd = Vector2(0.0, DOT_DISTANCE + LINE_LENGHT)

	_BotStart = Vector2(0.0, -DOT_DISTANCE)
	_BotEnd = Vector2(0.0, -DOT_DISTANCE - LINE_LENGHT)

	_RightStart = Vector2(DOT_DISTANCE, 0.0)
	_RightEnd = Vector2(DOT_DISTANCE + LINE_LENGHT, 0.0)

	_LeftStart = Vector2(-DOT_DISTANCE, 0.0)
	_LeftEnd = Vector2(-DOT_DISTANCE - LINE_LENGHT, 0.0)

func _draw_lines():
	_set_var()
	#Handle Color
	LineTop.default_color = DOT_COLOR
	LineBot.default_color = DOT_COLOR
	LineRight.default_color = DOT_COLOR
	LineLeft.default_color = DOT_COLOR
	#Handle Line
	LineTop.add_point(_TopStart)
	LineTop.add_point(_TopEnd)
	LineBot.add_point(_BotStart)
	LineBot.add_point(_BotEnd)
	LineRight.add_point(_RightStart)
	LineRight.add_point(_RightEnd)
	LineLeft.add_point(_LeftStart)
	LineLeft.add_point(_LeftEnd)
	#Handle Line Width
	LineTop.width = LINE_WIDTH
	LineBot.width = LINE_WIDTH
	LineRight.width = LINE_WIDTH
	LineLeft.width = LINE_WIDTH

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw() #redraw any draw in the script


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw():
	draw_circle(Vector2(0,0), DOT_RADIUS, DOT_COLOR) #draw reticle dot
	_draw_lines()
