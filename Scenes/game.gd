extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	get_child(0).reparent(%SubViewport)
