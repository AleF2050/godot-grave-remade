extends KinematicBody2D

# enum states
enum state {
	CHASE
	ATTACK
}

export var move_speed = 30
var _state = state.CHASE
var speed = Vector2.ZERO
var attack_range = 42

func _ready():
	$Animation.play("idle")


func _physics_process(delta):
	var player = get_tree().get_nodes_in_group("player").front()
	
	match _state:
		state.CHASE:
			$Animation.play("walk")
			if is_instance_valid(player):
				$SpritePivot.scale.x = sign(player.global_position.x - global_position.x)
			
			if get_position().distance_to(player.position) > attack_range:
				speed.x = ($SpritePivot.scale.x * move_speed)
			else:
				_state = state.ATTACK
			
			speed = move_and_slide(speed)
		
		state.ATTACK:
			$Animation.play("attack")


func _on_Animation_animation_finished(anim_name):
	if anim_name == "attack":
		_state = state.CHASE


# todo:
# - fix sprite jittering
# - prevent other objects from pushing
