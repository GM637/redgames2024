extends Panel

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_cancel") :
		if $Text/Button.disabled : 
			$Popup.play("Pop")
		else :
			$Popup.play_backwards("Pop")
