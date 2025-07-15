extends Area2D

##################################################
const SCREEN_SIZE: Vector2 = Vector2(640.0, 360.0)

var animated_sprite_node: AnimatedSprite2D

##################################################
func _ready() -> void:
	animated_sprite_node = $AnimatedSprite2D
	
	body_entered.connect(_on_body_entered)
	
	if global_position.y < SCREEN_SIZE.y / 2:
		animated_sprite_node.flip_v = true

##################################################
func _on_body_entered(body: Node2D) -> void:
	AM.play_coin_audio()
	queue_free()
