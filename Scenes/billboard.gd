extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if GameGlobal.cam :
		scale.y = lerp(scale.y , -sign(global_position.y - (GameGlobal.cam.global_position.y + GameGlobal.cam.offset.y) ), 0.03)
