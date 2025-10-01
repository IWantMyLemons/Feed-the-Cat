extends CharacterBody2D

class_name PlayerController

@export var SPEED = 20.0

var direction = 0

var speed_multiplier = 30.0



#const SPEED = 100.0
const JUMP_VELOCITY = -300.0

func _input(event):
	# Handle jump.
	if event.is_action_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		#Handle Jump Down
	if event.is_action_pressed("Move Down"):
		set_collision_mask_value(10,false)
	else:
		set_collision_mask_value(10,true)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("Move Left", "Move Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
