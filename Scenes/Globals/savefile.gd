extends Resource
class_name SaveFile

@export var Score = 0 :
	set(num) :
		Highscore = max(Score,Highscore)
		Score = num
@export var Highscore = 0

@export var music = 0.5
@export var sfx = 0.5
@export var camera_rot = true
