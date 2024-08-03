extends Area2D

#func _ready() -> void:
	#
	#await get_tree().create_timer(randf_range(0.1,0.5)).timeout
	#$Anim.play("Loop")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if GameGlobal.player :
		scale.y = lerp(scale.y , -sign(global_position.y - GameGlobal.player.global_position.y ), 0.05)
