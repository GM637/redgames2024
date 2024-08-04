extends Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	$Clouds.rotate_x(deg_to_rad(0.1))
	$Clouds.rotate_y(deg_to_rad(0.2))
	$Clouds.rotate_z(deg_to_rad(0.3))

	if Input.is_action_just_pressed("ui_accept") :
		
		if GameGlobal.save.name == "" :
			$Control.show()
			$Control/ColorRect/LineEdit.grab_focus()
			await $Control/ColorRect/LineEdit.text_submitted
			GameGlobal.save.name = $Control/ColorRect/LineEdit.text
			GameGlobal.saveData()
			$Control.hide()
			GameGlobal.change_scene("res://Scenes/shop.tscn")
		else :
			GameGlobal.change_scene("res://Scenes/shop.tscn")
