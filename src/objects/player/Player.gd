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
export var can_change_state = false
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
	
	# Disabling bool for permmitting combo input during combo animations, excluding attack animations.
	# It checks whenever attack animations are not playing so AnimationPlayer can safely execute methods on its own.
	if $Animation.current_animation != "n_attack1" and $Animation.current_animation != "n_attack2" and $Animation.current_animation != "n_attack3":
		can_chain_animation(false)
	
	
	# State check
	match _state:
		state.GROUND: # GROUND STATE
			# Moving the character
			if Input.is_action_pressed("k_left"):
				$SpritePivot.scale.x = -1
				$Animation.play("move")
				$Collider.scale.x = -1
				speed.x = -move_speed
			elif Input.is_action_pressed("k_right"):
				$SpritePivot.scale.x = 1
				$Animation.play("move")
				$Collider.scale.x = 1
				speed.x = move_speed
			else:
				$Animation.play("stand")
				speed = Vector2(0.0,0.0)
			
			# Roll character
			if Input.is_action_just_pressed("k_action1"):
				_state = state.ROLL
				if $SpritePivot.scale.x == -1:
					speed.x = -roll_speed
				elif $SpritePivot.scale.x == 1:
					speed.x = roll_speed
			speed = move_and_slide(speed)
			
			# Begin attack sequence
			if Input.is_action_just_pressed("k_action2"):
				_state = state.N_ATTACK1
				speed.x = 0
			
			
		state.ROLL: # ROLL STATE
			# Rolling
			$Animation.play("rolling")
			if !(speed.x >= 2 or speed.x <= 2):
				if $SpritePivot.scale.x == -1:
					speed.x += 2
				elif $SpritePivot.scale.x == 1:
					speed.x -= 2
			speed = move_and_slide(speed)
			
			
		state.N_ATTACK1: # NORMAL ATTACK STATE, SEQ 1
			$Animation.play("n_attack1")
			if Input.is_action_just_pressed("k_action2") && can_change_state == true:
				_state = state.N_ATTACK2
			
			
		state.N_ATTACK2: # NORMAL ATTACK STATE, SEQ 2
			$Animation.play("n_attack2")
			if Input.is_action_just_pressed("k_action2") && can_change_state == true:
				_state = state.N_ATTACK3
			
			
		state.N_ATTACK3: # NORMAL ATTACK STATE, SEQ 3
			$Animation.play("n_attack3")
			
			
	Signals.emit_signal("state_change", can_change_state) #Updates state for debugging


func _on_Animation_finished(anim_name):
	# Stop rolling after animation or finish attack animations and move on to GROUND state
	if anim_name == "rolling" or anim_name == "n_attack1" or anim_name == "n_attack2" or anim_name == "n_attack3":
		_state = state.GROUND
		$Animation.play("stand")
		speed.x = 0


func can_chain_animation(enable):
	# Method used for AnimationPlayer for enabling/disabling combo input chaining for animations
	can_change_state = enable





##SCRAPPED CODE
#func anim_hitframe_range(_min, _max):
#	# Checks whenever the current animation frame is under the specified frame range before going true.
#	return $SpritePivot/AnimatedSprite.frame >= _min and $SpritePivot/AnimatedSprite.frame <= _max


#func anim_hitframe(_frame):
#	# Checks whenever the current animation frame is under the specified frame before going true.
#	var _fr_range = $SpritePivot/AnimatedSprite.speed_scale
#	return $SpritePivot/AnimatedSprite.frame >= _frame and $SpritePivot/AnimatedSprite.frame < _fr_range

