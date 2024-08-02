@tool
extends Path2D

@export var Update = false 

func _process(delta: float) -> void:
	
	if Update :
		var polygon = curve.get_baked_points()
		$Road.points = polygon
