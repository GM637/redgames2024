extends CanvasLayer

@onready var wheel: Sprite2D = $Control/DownLeft/Wheel
var anims = ["Biggie","Tappy","Bam","Ugo"]

func _ready() -> void:
	
	$Control/DownRight/Buds/Buds.play(anims[GameGlobal.save.Equipped-1] )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.get_axis("ui_left", "ui_right") : 
		wheel.rotation_degrees = lerp(wheel.rotation_degrees, Input.get_axis("ui_left", "ui_right") * 800, 0.01)
	else :
		wheel.rotation_degrees = lerp(wheel.rotation_degrees, Input.get_axis("ui_left", "ui_right") * 90, 0.1)
		
	
	$Control/DownRight/Pedal.scale = lerp($Control/DownRight/Pedal.scale, Vector2(0.9,0.6) if Input.is_action_pressed("ui_accept") else Vector2(0.75,0.75), 0.2 )
	
	$Control/TopLeft/Score.text = "SCORE\n" + str(GameGlobal.save.Score).pad_zeros(5)
	$Control/TopLeft/Skew/Combo.text = "COMBO! \n     x" + str(GameGlobal.player.combo)
	
