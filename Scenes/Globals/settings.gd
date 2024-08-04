extends Panel

func  _ready() -> void:
	
	$Text/Master.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$Text/Music.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	$Text/SFX.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_cancel") :
		if $Text/Button.disabled : 
			$Popup.play("Popup")
			get_tree().paused = true
		else :
			$Popup.play_backwards("Popup")
			GameGlobal.saveData()
			get_tree().paused = false

	$SPrompt.text = "TAP" if OS.has_feature("web_android") else "ESC"

func _on_button_pressed() -> void:
	$Popup.play_backwards("Popup")
	get_tree().paused = false


func _on_music_value_changed(value: float) -> void:
	GameGlobal.save.music = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(value))

func _on_sfx_value_changed(value: float) -> void:
	GameGlobal.save.sfx = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(value))

func _on_master_value_changed(value: float) -> void:
	GameGlobal.save.volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear_to_db(value))
