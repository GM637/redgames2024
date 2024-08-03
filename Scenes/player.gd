extends CharacterBody2D
class_name PlayerCar

var direction = 0.0

var TURNSPEED = 5.0
var SPEED = 250.0

var turn = 0.0

func _physics_process(_delta: float) -> void:
	
	GameGlobal.player = self
	
	direction = Input.get_axis("ui_left", "ui_right")
	turn = lerp(turn, direction * TURNSPEED, 0.01)
	if !direction :
		turn = lerp(turn, direction * TURNSPEED, 0.05)
	
	rotate(deg_to_rad(turn))
	velocity = lerp(velocity,(Vector2.UP * (SPEED-turn)).rotated(global_rotation),0.1)
	$Cam.offset = (Vector2.UP * 160).rotated(global_rotation)
	
	$Cam.ignore_rotation = !GameGlobal.save.camera_rot
	
	if Input.is_action_just_pressed("ui_accept") :
		velocity = velocity.normalized() * 1500
	
	move_and_slide()
	
	$Grass.global_position = global_position
	$Cloud.global_position = global_position
	$Grass.region_rect.position = global_position
	$Cloud.region_rect.position += velocity * 0.007
	


func _on_boost_timeout() -> void:
	if velocity.length() > 500 :
		var d = $Drift.duplicate() as Sprite2D
		
		add_child(d)
		d.global_position = $SmokeDrift.global_position
		d.global_rotation_degrees = global_rotation_degrees
		d.show()

func add_coin() :
	
	GameGlobal.save.Coins += 1
	GameGlobal.coin()
	$SFX/Coin.play()


func _on_detect_area_entered(area: Area2D) -> void:
	
	if  area.is_in_group("Coin") :
		add_coin()
		
		var d = $CoinFx.duplicate() as Sprite2D
		
		add_child(d)
		d.global_position = area.global_position
		d.show()
		
		area.queue_free()
