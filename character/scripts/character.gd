extends CharacterBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

var vetocity = Vector2.ZERO

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree

func _physics_process(delta):
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
		
		if input_vector != Vector2.ZERO:
			animationTree.set("parameters/idle/blend_position", input_vector)
			animationTree.set("parameters/run/blend_position", input_vector)
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		else:
			animationPlayer.play("idle_right")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			
		move_and_collide(velocity * delta)
