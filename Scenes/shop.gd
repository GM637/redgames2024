extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	$TabContainer/Abilities/Biggie/Equip.visible = GameGlobal.save.Equipped == 1
	$TabContainer/Abilities/Tappy/Equip.visible = GameGlobal.save.Equipped == 2
	$TabContainer/Abilities/Bam/Equip.visible = GameGlobal.save.Equipped == 3
	$TabContainer/Abilities/Ugo/Equip.visible = GameGlobal.save.Equipped == 4
	
	$TabContainer/Upgrades/Turnspeed/Level.text = "LVL " +str(GameGlobal.save.upgrades[0])
	$TabContainer/Upgrades/Steeringsnap/Level.text = "LVL " +str(GameGlobal.save.upgrades[1])
	$TabContainer/Upgrades/OffroadGrip/Level.text = "LVL " +str(GameGlobal.save.upgrades[2])
	$TabContainer/Upgrades/AccelPower/Level.text = "LVL " +str(GameGlobal.save.upgrades[3])



func _on_turnspeed_pressed() -> void:
	if GameGlobal.save.Coins >= 100 :
		GameGlobal.save.Coins -= 100
		GameGlobal.save.upgrades[0] += 1

func _on_steeringsnap_pressed() -> void:
	if GameGlobal.save.Coins >= 100 :
		GameGlobal.save.Coins -= 100
		GameGlobal.save.upgrades[1] += 1

func _on_offroad_grip_pressed() -> void:
	if GameGlobal.save.Coins >= 100 :
		GameGlobal.save.Coins -= 100
		GameGlobal.save.upgrades[2] += 1

func _on_accel_power_pressed() -> void:
	if GameGlobal.save.Coins >= 100 :
		GameGlobal.save.Coins -= 100
		GameGlobal.save.upgrades[3] += 1




func _on_biggie_pressed() -> void:
	$TabContainer/Abilities/Desc.text = "Biggie :\nDouble Coins Dash!"
	GameGlobal.save.Equipped = 1

func _on_tappy_pressed() -> void:
	$TabContainer/Abilities/Desc.text = "Tappy :\nMAgic Blanket Spin!"
	GameGlobal.save.Equipped = 2

func _on_bam_pressed() -> void:
	$TabContainer/Abilities/Desc.text = "Bam :\nChill Slow Mo~"
	GameGlobal.save.Equipped = 3

func _on_ugo_pressed() -> void:
	$TabContainer/Abilities/Desc.text = "Biggie :\nMusical Rave!"
	GameGlobal.save.Equipped = 4



func _on_button_pressed() -> void:
	GameGlobal.saveData()
	GameGlobal.change_scene("res://Scenes/game.tscn")
