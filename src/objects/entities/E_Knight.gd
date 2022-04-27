extends KinematicBody2D

# enum states
enum state {
	CHASE
}

var _state = state.CHASE
export var move_speed = 30
var speed = Vector2.ZERO

func _ready():
	$Animation.play("idle")

# warning-ignore:unused_argument
func _physics_process(delta):
	var player = get_tree().get_nodes_in_group("player").front()
	
	match _state:
		state.CHASE:
			$Animation.play("walk")
			if is_instance_valid(player):
				$SpritePivot.scale.x = sign(player.global_position.x - global_position.x)
			
			if get_position().distance_to(player.position) > 42:
				speed.x = ($SpritePivot.scale.x * move_speed)
			else:
				speed.x = 0
			
			speed = move_and_slide(speed)

# todo:
# - fix sprite jittering
# - prevent other objects from pushing
