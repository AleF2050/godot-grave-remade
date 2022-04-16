extends Node

# Initiating game stuff
func _ready():
	var myScreenSize = Vector2.ZERO
	myScreenSize = OS.get_window_size()
	OS.set_window_size(myScreenSize*2)
	OS.set_window_position(
		OS.get_screen_position(OS.get_current_screen()) + 
		OS.get_screen_size()*0.5 - OS.get_window_size()*0.5)
	var player = load("res://src/objects/player/Player.tscn")
	player.connect("state_change",self,"debug_update_player_state")


func _process(delta):
	pass

func debug_update_player_state(string):
	$DEBUG/Label.text = str(string)
