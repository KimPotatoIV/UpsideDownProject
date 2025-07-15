extends Node2D

##################################################
const CAMERA_SHAKE_DURATION: float = 0.25
const CAMERA_SHAKE_INITIAL_STRENGTH: float = 4.0
const CAMERA_SHAKE_DAMPING: float = 0.9

var camera_node: Camera2D

var is_camera_shaking: bool = false
var camera_shake_elapsed_time: float = 0.0
var camera_shake_strength: float = \
CAMERA_SHAKE_INITIAL_STRENGTH

##################################################
func _ready() -> void:
	camera_node = $Camera2D
	
	SB.upside_down_signal.connect(_upside_down)

##################################################
func _process(delta: float) -> void:
	if is_camera_shaking:	
		_shake_camera()
		camera_shake_elapsed_time += delta
		if camera_shake_elapsed_time >= CAMERA_SHAKE_DURATION:
			is_camera_shaking = false
			camera_shake_elapsed_time = 0.0
			camera_node.offset = Vector2.ZERO
			camera_shake_strength = CAMERA_SHAKE_INITIAL_STRENGTH

##################################################
func _shake_camera() -> void:
	var offset = \
	Vector2(randf_range(-camera_shake_strength, camera_shake_strength), \
	randf_range(-camera_shake_strength, camera_shake_strength))
	camera_shake_strength *= CAMERA_SHAKE_DAMPING
	camera_node.offset = offset 

##################################################
func _upside_down() -> void:
	is_camera_shaking = true
