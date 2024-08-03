extends CharacterBody2D
class_name Player

var direction = 0.0

var TURNSPEED = 5.0
var SPEED = 200.0

var turn = 0.0

func _physics_process(delta: float) -> void:
	
	direction = Input.get_axis("ui_left", "ui_right")
	turn = lerp(turn, direction * TURNSPEED, 0.01)
	if !direction :
		turn = lerp(turn, direction * TURNSPEED, 0.05)
	
	rotate(deg_to_rad(turn))
	velocity = lerp(velocity,(Vector2.UP * (SPEED-turn)).rotated(global_rotation),0.1)
	$Cam.offset = (Vector2.UP * 160).rotated(global_rotation)
	
	$Cam.ignore_rotation = !GameGlobal.save.camera_rot
	
	move_and_slide()
	
	$Grass.global_position = global_position
	$Cloud.global_position = global_position
	$Grass.region_rect.position = global_position
	$Cloud.region_rect.position += velocity * 0.005
