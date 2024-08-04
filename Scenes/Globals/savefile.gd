extends Resource
class_name SaveFile

@export var name = ""

@export var Score = 0 :
	set(num) :
		Highscore = max(Score,Highscore)
		Score = num
@export var Highscore = 0

@export var Coins = 0

@export var Equipped = 1

@export var upgrades = [1,1,1,1]
@export var unlockes = [true,false,false,false]

@export var music = 0.5
@export var sfx = 0.5
@export var volume = 0.5
