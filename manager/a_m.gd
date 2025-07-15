extends Node

##################################################
const COIN_AUDIO: AudioStream = preload("res://audio/coin.wav")
const JUMP_AUDIO: AudioStream = preload("res://audio/jump.wav")
const BGM: AudioStream = preload("res://audio/time_for_adventure.mp3")

var sfx_player: AudioStreamPlayer
var bgm_player: AudioStreamPlayer

##################################################
func _ready() -> void:
	sfx_player = AudioStreamPlayer.new()
	sfx_player.volume_db = -10.0
	add_child(sfx_player)
	
	bgm_player = AudioStreamPlayer.new()
	add_child(bgm_player)
	bgm_player.stream = BGM
	bgm_player.play()

##################################################
func play_coin_audio() -> void:
	sfx_player.stream = COIN_AUDIO
	sfx_player.play()

##################################################
func play_jump_audio() -> void:
	sfx_player.stream = JUMP_AUDIO
	sfx_player.play()
