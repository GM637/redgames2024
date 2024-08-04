extends CanvasLayer

var save := SaveFile.new()
var safe := "01S01)9u3j1js0nnxnm09JDS01DSS10))*@*jJS"

var player : PlayerCar
var cam : Camera2D

func _ready() -> void:
	
	loadData()
	
	$Control/Fade/Control/Buds.play("Ugo")
	$Control/Fade/Control/Buds2.play("Bam")
	$Control/Fade/Control/Buds3.play("Tappy")
	$Control/Fade/Control/Buds4.play("Biggie")

func _process(_delta: float) -> void:
	
	$Control/Coin.text = str(save.Coins).pad_zeros(4)

func saveData() :
	
	var file := FileAccess.open_encrypted_with_pass("user://save1.dat", FileAccess.WRITE,safe)
	
	file.store_string(var_to_str(save))
	
	file.close()
	
	print("Saved :")
	print(var_to_str(save))
	
	$Control/Savetext.show()
	await get_tree().create_timer(1.0).timeout
	$Control/Savetext.hide()

func loadData() :
	
	if FileAccess.file_exists("user://save1.dat"):
		var file := FileAccess.open_encrypted_with_pass("user://save1.dat", FileAccess.READ,safe)
		
		var gets = str_to_var(file.get_as_text())
		
		file.close()
		
		save = gets 
		if save == null :
			save = SaveFile.new()
			print("Reset :")
			print(var_to_str(save))
			$Control/NewSave.show()
			await get_tree().create_timer(1.0).timeout
			$Control/NewSave.hide()
			return
		
		print("Loaded :")
		print(var_to_str(save))
		
		$Control/LoadText.show()
		await get_tree().create_timer(1.0).timeout
		$Control/LoadText.hide()

func coin() :
	$Control/Coin/Coin/Coin3/Pop.stop()
	$Control/Coin/Coin/Coin3/Pop.play("Pop")
	

func change_scene(scene : String) :
	$Control/Fade/Anim.play("Fade")
	await $Control/Fade/Anim.animation_finished
	get_tree().change_scene_to_file(scene)
	$Control/Fade/Anim.play_backwards("Fade")
