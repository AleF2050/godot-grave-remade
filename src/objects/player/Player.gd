extends KinematicBody2D

# ENUM FOR STATES
enum {
	GROUND,
	ROLL
}

# ... INIT VARIABLES
export var move_speed = 90
export var roll_speed = 160
var speed = Vector2()
var _state = GROUND

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
		GROUND: # GROUND STATE
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
				
			if Input.is_action_pressed("k_action1"):
				$AnimatedSprite.animation = "rolling"
				_state = ROLL
				if $AnimatedSprite.flip_h == true:
					speed.x = -roll_speed
				elif $AnimatedSprite.flip_h == false:
					speed.x = roll_speed
			
			speed = move_and_slide(speed)
		ROLL: # ROLL STATE
			# Rolling
			if !(speed.x >= 2 or speed.x <= 2):
				if $AnimatedSprite.flip_h == true:
					speed.x += 2
				elif $AnimatedSprite.flip_h == false:
					speed.x -= 2
			speed = move_and_slide(speed)


func _on_AnimatedSprite_animation_finished():
	# Stop rolling after animation and move on to GROUND state
	if $AnimatedSprite.animation == "rolling":
		_state = GROUND
		$AnimatedSprite.animation = "stand"
		speed.x = 0
