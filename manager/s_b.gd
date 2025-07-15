extends Node

##################################################
signal upside_down_signal

##################################################
func emit_upside_down_signal() -> void:
	emit_signal("upside_down_signal")
