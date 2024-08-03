extends CanvasLayer

@onready var wheel: Sprite2D = $Control/DownLeft/Wheel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.get_axis("ui_left", "ui_right") : 
		wheel.rotation_degrees = lerp(wheel.rotation_degrees, Input.get_axis("ui_left", "ui_right") * 800, 0.01)
	else :
		wheel.rotation_degrees = lerp(wheel.rotation_degrees, Input.get_axis("ui_left", "ui_right") * 90, 0.1)
