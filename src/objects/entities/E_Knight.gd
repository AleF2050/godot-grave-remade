extends KinematicBody2D

# enum states
enum state {
	CHASE
}

var _state = state.CHASE

func _ready():
	$Animation.play("idle")

# warning-ignore:unused_argument
func _physics_process(delta):
	var player = get_tree().get_nodes_in_group("player").front()
	
	match _state:
		state.CHASE:
			$Animation.play("walk")
			if is_instance_valid(player):
				print("There is a player.")
				$SpritePivot.scale.x = sign(player.global_position.x - global_position.x)

# https://www.youtube.com/watch?v=boHDx303FUo&list=PL9FzW-m48fn0mblTG_KFDg81AMXDPKBE5&index=11  7:30
