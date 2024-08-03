extends Panel

func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_cancel") :
		if $Text/Button.disabled : 
			$Popup.play("Popup")
			get_tree().paused = true
		else :
			$Popup.play_backwards("Popup")
			get_tree().paused = false


func _on_button_pressed() -> void:
	$Popup.play_backwards("Popup")
	get_tree().paused = false
