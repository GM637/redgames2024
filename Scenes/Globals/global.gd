extends CanvasLayer

var save := SaveFile.new()
var safe := "01S01)9u3j1js0nnxnm09JDS01DSS10))*@*jJS"

var player : PlayerCar

func saveData() :
	
	var file := FileAccess.open_encrypted_with_pass("user://save1.dat", FileAccess.WRITE,safe)
	
	file.store_string(var_to_str(save))
	
	file.close()
	
	print("Saved :")
	print(var_to_str(save))

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
			return
		
		print("Loaded :")
		print(var_to_str(save))

func coin() :
	$Control/Coin/Coin/Coin3/Pop.stop()
	$Control/Coin/Coin/Coin3/Pop.play("Pop")
	$Control/Coin.text = str(save.Coins).pad_zeros(4)
