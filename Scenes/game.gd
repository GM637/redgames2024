extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	get_child(0).reparent(%SubViewport)
	GameGlobal.save.Score = 0

func _process(_delta: float) -> void:
	
	%End.progress_ratio = 1.0 
