extends CharacterBody2D
class_name PlayerController

signal player_death
signal collect_spam
signal lose_spam

@export var SPEED = 85
@export var spam_scene: PackedScene
@export var bonus_jumps = 0

var direction = 0

var speed_multiplier = 50

#const SPEED = 100.0
const JUMP_VELOCITY = -300.0

# Coyote time
@onready var coyote_timer = $CoyoteTimer
var was_on_floor = false

func can_jump():
	return is_on_floor() or !coyote_timer.is_stopped()

func _input(event):
	# Handle jump.
	if event.is_action_pressed("Jump") and can_jump():
		velocity.y = JUMP_VELOCITY
	# Handle spam jump
	elif event.is_action_pressed("Jump") and bonus_jumps > 0 and not can_jump():
		var spam: Spam = spam_scene.instantiate()
		spam.position = self.position + Vector2(0, 5)
		get_parent().add_child(spam)
		bonus_jumps -= 1
		lose_spam.emit(spam)
		velocity.y = JUMP_VELOCITY
	#Handle Jump Down
	if event.is_action_pressed("Move Down"):
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)


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
	
	# Update coyote timer
	if is_on_floor():
		was_on_floor = true
	elif was_on_floor:
		was_on_floor = false
		coyote_timer.start()
	
	move_and_slide()

func _on_pickup_entered(body: Node2D) -> void:
	if body.has_method("pickup"):
		if body is Spam:
			collect_spam.emit(body)
		body.pickup(self)
	else:
		push_warning("Tried to pickup object without pickup() method")


func _on_hurt_box_entered(_body: Node2D) -> void:
	get_tree().call_deferred("reload_current_scene")
	
