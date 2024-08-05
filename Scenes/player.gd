extends CharacterBody2D
class_name PlayerCar

var direction = 0.0

var TURNSPEED = 5.0
var SPEED = 250.0

var turn = 0.0
var shake = 0.0

var combo = 0
var coins = 1

func _physics_process(_delta: float) -> void:
	
	shake *= 0.9
	
	GameGlobal.player = self
	GameGlobal.cam = $Cam
	
	direction = Input.get_axis("ui_left", "ui_right")
	turn = lerp(turn, direction * TURNSPEED, 0.01 + (GameGlobal.save.upgrades[0] * 0.005) )
	if !direction :
		turn = lerp(turn, direction * TURNSPEED, 0.05 + (GameGlobal.save.upgrades[1] * 0.01) )
	
	if abs(turn) > 2 and !$SFX/Drift.playing :
		$SFX/Drift.play()
	
	rotate(deg_to_rad(turn))
	velocity = lerp(velocity,(Vector2.UP * (SPEED-turn)).rotated(global_rotation),0.1)
	$Cam.offset = (Vector2.UP * 160).rotated(global_rotation) + Vector2(randf_range(-shake,shake),randf_range(-shake,shake))
	
	if Input.is_action_pressed("ui_accept") :
		velocity = lerp(velocity,velocity.normalized() * SPEED * 2.5,0.2)
	
	move_and_slide()
	
	$Grass.global_position = global_position
	$Cloud.global_position = global_position
	$Grass.region_rect.position = global_position
	$Cloud.region_rect.position += velocity * 0.007
	
	$SFX/Engine.pitch_scale = velocity.length() / 250.0
	
	if Input.is_action_just_pressed("Buds") and %Buds.modulate.a >= 0.99 :
		get_tree().create_tween().tween_property(%Buds,"modulate",Color(1,1,1,0),0.5)
		get_tree().create_tween().tween_property(%Buds,"scale",Vector2(2,2),0.5)
		$SFX/Powerup.play(0.0)
		match GameGlobal.save.Equipped :
			1:
				coins = 2
				SPEED += 30
				await get_tree().create_timer(5.0).timeout
				coins = 1
				SPEED -= 30
			2:
				$Car.rotation_degrees = 0.0
				get_tree().create_tween().tween_property($Car,"rotation_degrees",360*10,5.0)
			3:
				Engine.time_scale *= 0.5
				await get_tree().create_timer(Engine.time_scale * 5.0).timeout
				Engine.time_scale /= 0.5
		
	
	if %Buds.modulate.a <= 0.0 :
		get_tree().create_tween().tween_property(%Buds,"modulate",Color.WHITE,10.0-GameGlobal.save.upgrades[3]*0.5)
		get_tree().create_tween().tween_property(%Buds,"scale",Vector2(1,1),0.5)

func _on_boost_timeout() -> void:
	if velocity.length() > 500 :
		var d = $Drift.duplicate() as Sprite2D
		
		add_child(d)
		d.global_position = $SmokeDrift.global_position
		d.global_rotation_degrees = global_rotation_degrees
		d.show()

func add_coin() :
	
	GameGlobal.save.Coins += coins
	GameGlobal.coin()
	$SFX/Coin.play()


func _on_detect_area_entered(area: Area2D) -> void:
	
	if  area.is_in_group("Coin") :
		add_coin()
		GameGlobal.save.Score += 10
		
		var d = $CoinFx.duplicate() as Sprite2D
		
		add_child(d)
		d.global_position = area.global_position
		d.show()
		
		area.queue_free()
		
	if  area.is_in_group("Bush") :
		
		if velocity.length() < 300 :
			velocity *= 0.1
			poof()
		$SFX/Bush.play()
		
	if  area.is_in_group("Cone") :
		
		if velocity.length() < 300 :
			velocity *= -2
			shake = 5
		else :
			Engine.time_scale = 0.1
			GameGlobal.save.Score += 20
			shake = 15
			poof()
			await get_tree().create_timer(0.05).timeout
			Engine.time_scale = 1.0
			SPEED += 10
			combo += 1
		$SFX/Thud.play(0.5)
		get_tree().create_tween().tween_property(area,"global_position",(area.global_position-global_position).normalized() * velocity.length() * 0.5,0.3).as_relative().set_trans(Tween.TRANS_EXPO)
	if  area.is_in_group("Hole") :
		
		GameGlobal.save.Score += (combo * combo * 10)
		combo = 0
		$Car/Guy.hide()
		
		velocity *= 0.0
		shake = 50
		SPEED = 250
		$SFX/Crush.play(0.35)
		poof()
	if  area.is_in_group("Flag") :
		
		if $Car/Guy.visible :
			GameGlobal.save.Score += 1000
			GameGlobal.save.Coins += 100
			GameGlobal.coin()
			$SFX/Coin.play()
		$Car/Guy.visible = !$Car/Guy.visible
		poof()

func poof() :
	
	var d = $POOF.duplicate()
	add_child(d)
	d.restart()


func _on_end_stage(_body: Node2D) -> void:
	GameGlobal.save.Score += int($Timer.time_left * 100)
	Leaderboards.post_guest_score("buds-world-adventure-city-yfyK",GameGlobal.save.Score,GameGlobal.save.name)
	GameGlobal.saveData()
	GameGlobal.change_scene("res://Scenes/shop.tscn")
