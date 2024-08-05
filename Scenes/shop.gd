extends Control

var anims = ["Biggie","Tappy","Bam","Ugo"]

func _ready() -> void:
	
	$Shop/Buds.play(anims[GameGlobal.save.Equipped-1] )
	$TabContainer/Driver/Biggie/Buds.play("Biggie")
	$TabContainer/Driver/Tappy/Buds.play("Tappy")
	$TabContainer/Driver/Bam/Buds.play("Bam")
	$TabContainer/Driver/Ugo/Buds.play("Ugo")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	$TabContainer/Driver/Biggie/Equip.visible = GameGlobal.save.Equipped == 1
	$TabContainer/Driver/Tappy/Equip.visible = GameGlobal.save.Equipped == 2
	$TabContainer/Driver/Bam/Equip.visible = GameGlobal.save.Equipped == 3
	$TabContainer/Driver/Ugo/Equip.visible = GameGlobal.save.Equipped == 4
	
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
	$TabContainer/Driver/Desc.text = "Biggie :\nDouble Coins Dash!"
	$TabContainer/Driver/Biggie/Buds.play("Biggie")
	GameGlobal.save.Equipped = 1
	$Shop/Buds.play("Biggie")

func _on_tappy_pressed() -> void:
	$TabContainer/Driver/Desc.text = "Tappy :\nMAgic Blanket Spin!"
	$TabContainer/Driver/Tappy/Buds.play("Tappy")
	GameGlobal.save.Equipped = 2
	$Shop/Buds.play("Tappy")

func _on_bam_pressed() -> void:
	$TabContainer/Driver/Desc.text = "Bam :\nChill Slow Mo~"
	$TabContainer/Driver/Bam/Buds.play("Bam")
	GameGlobal.save.Equipped = 3
	$Shop/Buds.play("Bam")

func _on_ugo_pressed() -> void:
	$TabContainer/Driver/Desc.text = "Ugo :\nMusical Rave!"
	$TabContainer/Driver/Ugo/Buds.play("Ugo")
	GameGlobal.save.Equipped = 4
	$Shop/Buds.play("Ugo")


func _on_button_pressed() -> void:
	GameGlobal.saveData()
	GameGlobal.change_scene("res://Scenes/game.tscn")
