extends CharacterBody2D

##################################################
const SCREEN_SIZE: Vector2 = Vector2(640.0, 360.0)
const MOVING_SPEED = 50.0

var animated_sprite_node: AnimatedSprite2D
var ray_cast_left_node: RayCast2D
var ray_cast_right_node: RayCast2D

var x_direction: float = 1

##################################################
func _ready() -> void:
	animated_sprite_node = $AnimatedSprite2D
	ray_cast_left_node = $RayCast2DL
	ray_cast_right_node = $RayCast2DR

##################################################
func _physics_process(delta: float) -> void:
	# 화면 y축 위치에 따라 중력 방향을 각각 다르게 설정
	if global_position.y < SCREEN_SIZE.y / 2:
		velocity -= get_gravity() * delta
	else:
		velocity += get_gravity() * delta
	
	if ray_cast_left_node.is_colliding() or ray_cast_right_node.is_colliding():
		x_direction *= -1
	
	if global_position.y < SCREEN_SIZE.y / 2:
		animated_sprite_node.flip_h = (x_direction == 1)
	else:
		animated_sprite_node.flip_h = (not x_direction == 1)
	velocity.x = x_direction * MOVING_SPEED

	move_and_slide()
