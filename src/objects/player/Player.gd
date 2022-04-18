extends KinematicBody2D

# ENUM FOR STATES
enum state {
	GROUND,
	ROLL
	N_ATTACK1
	N_ATTACK2
	N_ATTACK3
}

# ... INIT VARIABLES
export var move_speed = 90
export var roll_speed = 160
var speed = Vector2()
var _state = state.GROUND

#export var gravity = 3
#export var run_speed_factor = 1.8
#var run_speed = move_speed * run_speed_factor

# ... INIT NODE REFERENCES
onready var player = get_node(".")

# ... READY
func _ready():
	pass

# ... PHYSICS PROCESS (mostly for movement)
func _physics_process(delta):
	# State check
	match _state:
		state.GROUND: # GROUND STATE
			# Moving the character
			if Input.is_action_pressed("k_left"):
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.animation = "move"
				$Collider.scale.x = -1
				speed.x = -move_speed
			elif Input.is_action_pressed("k_right"):
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.animation = "move"
				$Collider.scale.x = 1
				speed.x = move_speed
			else:
				$AnimatedSprite.animation = "stand"
				speed = Vector2(0.0,0.0)
			
			# Roll character
			if Input.is_action_just_pressed("k_action1"):
				_state = state.ROLL
				if $AnimatedSprite.flip_h == true:
					speed.x = -roll_speed
				elif $AnimatedSprite.flip_h == false:
					speed.x = roll_speed
			speed = move_and_slide(speed)
			
			# Begin attack sequence
			if Input.is_action_just_pressed("k_action2"):
				$AnimatedSprite.animation = "n_attack1"
				_state = state.N_ATTACK1
			
			
		state.ROLL: # ROLL STATE
			# Rolling
			$AnimatedSprite.animation = "rolling"
			if !(speed.x >= 2 or speed.x <= 2):
				if $AnimatedSprite.flip_h == true:
					speed.x += 2
				elif $AnimatedSprite.flip_h == false:
					speed.x -= 2
			speed = move_and_slide(speed)
			
			
	Signals.emit_signal("state_change", _state)


func _on_AnimatedSprite_animation_finished():
	# Stop rolling after animation and move on to GROUND state
	if $AnimatedSprite.animation == "rolling":
		_state = state.GROUND
		$AnimatedSprite.animation = "stand"
		speed.x = 0
	
	# End n. attack 1-etc. animations if nothing has been inputted.
	if $AnimatedSprite.animation == "n_attack1":
		_state = state.GROUND
		$AnimatedSprite.animation = "stand"
		speed.x = 0
