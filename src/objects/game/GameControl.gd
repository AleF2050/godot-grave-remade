extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#Initiating game stuff
func _ready():
	var myScreenSize = Vector2.ZERO
	myScreenSize = OS.get_window_size()
	OS.set_window_size(myScreenSize*2)
	OS.set_window_position(
		OS.get_screen_position(OS.get_current_screen()) + 
		OS.get_screen_size()*0.5 - OS.get_window_size()*0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
