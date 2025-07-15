extends CharacterBody2D

##################################################
const AFTER_IMAGE_SCENE: PackedScene = \
preload("res://scenes/after_image/after_image.tscn")

const MOVING_SPEED = 100.0
const AFTER_IMAGE_INTERVAL: float = 0.05

@onready var after_images_node = get_tree().root.get_node("Main/AfterImages")

var animated_sprite_node: AnimatedSprite2D
var collision_shape_node: CollisionShape2D

var gravity_direction: float = 1		# 실시간 중력 방향
var after_image_timer: float = 0.0

##################################################
func _ready() -> void:
	animated_sprite_node = $AnimatedSprite2D
	collision_shape_node = $CollisionShape2D

##################################################
func _physics_process(delta: float) -> void:
	if not is_on_ground():
		# gravity_direction에 따라 중력을 위아래로 다르게 줌
		velocity += get_gravity() * delta * gravity_direction
		animated_sprite_node.play("jump")
		
		after_image_timer += delta
		if after_image_timer >= AFTER_IMAGE_INTERVAL:
			after_image_timer = 0.0
			_spawn_after_image()
	
	# 지면에 닿아 있으면서 스케이스 키를 누르면
	if Input.is_action_just_pressed("ui_accept") and is_on_ground():
		gravity_direction *= -1					# 중력 방향을 바꿈
		collision_shape_node.position.y *= -1	# 중력에 따라 collision 방향을 바꿈
		SB.emit_upside_down_signal()
		AM.play_jump_audio()
		
		# 중력 방향에 따라 sprite 방향을 바꿈
		if is_on_ceiling():
			animated_sprite_node.flip_v = false
		elif is_on_floor():
			animated_sprite_node.flip_v = true

	var x_direction: float = Input.get_axis("ui_left", "ui_right")
	if x_direction:
		velocity.x = x_direction * MOVING_SPEED
		if is_on_ground():
			animated_sprite_node.play("run")
		if x_direction > 0:
			animated_sprite_node.flip_h = false
		elif x_direction < 0:
			animated_sprite_node.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, MOVING_SPEED)
		
		if is_on_ground():
			animated_sprite_node.play("idle")

	move_and_slide()

##################################################
func is_on_ground() -> bool:	# 중력에 따라 바닥에 서 있는지 판단하는 함수
	if gravity_direction == 1:		# 중력이 아래로 향할 때
		return is_on_floor()
	elif gravity_direction == -1:	# 중력이 위로 향할 때
		return is_on_ceiling()
	else:
		return false
# CharacterBody2D 노드 인스펙터 창에서 'Up Direction'의 y 방향을 반대로 변경하여 사용도 가능

##################################################
func _spawn_after_image() -> void:
	var after_image_instance: Node2D = AFTER_IMAGE_SCENE.instantiate()
	after_image_instance.global_position = global_position
	
	var sprite = after_image_instance.get_node("Sprite2D")
	sprite.texture = \
	animated_sprite_node.sprite_frames.get_frame_texture(animated_sprite_node.animation, animated_sprite_node.frame)
	sprite.flip_h = animated_sprite_node.flip_h
	
	after_images_node.add_child(after_image_instance)
