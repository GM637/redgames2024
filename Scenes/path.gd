@tool
extends Path2D

var rot = 0.0

@export var Update = false 
@export var Add_road = false :
	set(tru) :
		if tru :
			add_road()
		else :
			curve.remove_point(curve.point_count-1)

func _ready() -> void:
	
	for i in range(50) :
		add_road()

func _process(delta: float) -> void:
	
	if Update :
		var polygon = curve.get_baked_points()
		$Road.points = polygon
		$Road2.points = polygon

func add_road() :
	
	var count = curve.point_count
	var curr = curve.get_point_position(count-1)
	var prev = curve.get_point_position(count-2)
	
	var to =  (curr - prev).normalized()
	if randf_range(0,1) < 0.4 or rot == 0.0 or abs(rot) >= 60.0 :
		rot = randf_range(-30,30)
	else :
		rot *= randf_range(1,2)
	
	var towards = to.rotated(deg_to_rad(rot))
	var pos = curr + (towards * randf_range(512,1280))
	
	var in_ = calculate_curve_control_points(curr,pos)
	
	curve.add_point(pos, in_)
	curve.set_point_out(count-1,-curve.get_point_in(count-1))
	
	add_prop()

func calculate_curve_control_points(point_a: Vector2, point_b: Vector2) :
	
	var midpoint: Vector2 = (point_a + point_b) / 2
	var direction_vector: Vector2 = point_b - point_a
	var normalized_direction: Vector2 = direction_vector.normalized()
	var in_control_b: Vector2 = -normalized_direction * (point_a.distance_to(point_b) / 2.5)

	return in_control_b

func add_prop() :
	
	var curr = curve.point_count - 2
	
	match randi_range(1,3) :
		1:
			# coins thing
			var dir = ( float( randi_range(0,1) ) - 0.5) * 2
			
			for i in randi_range(0,15) :
				
				var trans = curve.sample_baked_with_rotation( curve.get_closest_offset(curve.get_point_position(curr)) + (i*64) )
				var pos = trans.origin + (Vector2.RIGHT.rotated(trans.get_rotation()) * 256 * dir)
				var c = $Coin.duplicate() as Area2D
				add_child(c)
				
				c.global_position = pos
		2:
			# bush thing
			
			for i in randi_range(0,2) :
				var dir = ( float( randi_range(0,1) ) - 0.5) * 2
				
				var trans = curve.sample_baked_with_rotation( curve.get_closest_offset(curve.get_point_position(curr)) + (i*90) )
				var pos = trans.origin + (Vector2.RIGHT.rotated(trans.get_rotation()) * randf_range(256,720) * dir)
				var b = $Bush.duplicate() as Area2D
				add_child(b)
				
				b.position = pos
		3:
			# bush thing
			
			for i in randi_range(0,5) :
				var dir = ( float( randi_range(0,1) ) - 0.5) * 2
				
				var trans = curve.sample_baked_with_rotation( curve.get_closest_offset(curve.get_point_position(curr)) + (i*90) )
				var pos = trans.origin + Vector2(randf_range(-256,256),randf_range(-256,256))
				var c = $Cone.duplicate() as Area2D
				add_child(c)
				
				c.position = pos
