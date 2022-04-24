extends KinematicBody2D

# enum states
enum state {
	CHASE
}

var _state = state.CHASE

func _ready():
	$Animation.play("idle")

func _physics_process(delta):
	match _state:
		state.CHASE:
			var player_exists = get_tree().get_nodes_in_group("player")[0]
			
			$Animation.play("walk")
			if player_exists:
				print("There is a player.")

# https://www.youtube.com/watch?v=boHDx303FUo&list=PL9FzW-m48fn0mblTG_KFDg81AMXDPKBE5&index=11  7:30
