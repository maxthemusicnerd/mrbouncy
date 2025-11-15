extends RigidBody2D

@export var gravity: int = 100
var velocity = Vector2(450, 450)

func _physics_process(delta: float) -> void:


	#velocity = move_toward()
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collision_point = collision_info.get_position()
		velocity = velocity.bounce(collision_info.get_normal())
