extends PanelContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("debug"):
		visible = !visible
#
#func _add_debug_property(title : String, value):
	#property = Label.new()
	#property_container.add_child(property)
	#property.name = title
