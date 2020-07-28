extends Node


# Signals
signal new_game
signal game_over
signal moving_numbers
signal exit_game
signal save_player_data

#Scenes
var number_scene = preload("res://Scenes/Number.tscn")
var ads_scene = preload("res://Scenes/ADs.tscn")
var gamefield_scene = preload("res://Scenes/GameField.tscn")
var background_scene = preload("res://Scenes/Background.tscn")
var game_field_scene = preload("res://Scenes/GameField.tscn")

# GUI Scenes
var gui_scene = preload("res://Scenes/GUI.tscn")
var gui_gameover_scene = preload("res://Scenes/GUI_GameOver.tscn")

#Nodes
var inputLagTimer = null
#var number = null 
var gui_node = null
var ads_node = null
var gui_gameover_node = null
var background_node = null
var mainWindow_node = null
var gamefield_node = null

#Scripts
#var mainWindow_script = preload("res://Scripts/MainWindow.gd").new()
#var number_script = preload("res://Scripts/Number.gd").new()
#var ads_script = preload("res://Scripts/ADs.gd").new()
#var gamefield_script = preload("res://Scripts/GameField.gd").new()
#var background_script = preload("res://Scripts/Background.gd").new()
#var gui_script = preload("res://Scripts/GUI.gd").new()
#var gui_gameover_script = preload("res://Scripts/GUI_GameOver.gd").new()


var screenSize = Vector2(0,0)
var game_window_width_x = 500
var game_window_heigth_y = 800
var game_window_margin = 0

var game_field_width_x = 500
var game_field_margin = 0

var number_size = 80

var clickInput = false

const game_field_size = 4 

var hard_level = 3
var iq_level = 0
var new_game_numbers = 3

var is_dark = false
var curr_color_them = "light"
var main_background_color ="73947A"
var plate_background_color ="5E7478"
var menu_machground = "A5B48C"
var text_color = "363636"

var summ = 0
var sumb = 0
var eend = 4
var koldop = 2
var kodn
var pst = 0.05
var kodurv = 3

# for testing old value = 1, 2
var number_one = 2
var number_two = 4
var number_three = 8
var number_four = 16
var number_five = 32

var undo_game_field = null
var is_undo_copied = false						  
var game_field = [[],[]]

var randgen = RandomNumberGenerator.new()

var current_score = 0
var best_score = 0
var scores_dict = {"1st    ": 32768, "2st    ": 16384, "3st    ": 8192, "4st    ": 4096, "5st    ": 2048, "6st    ": 1600, "7st    ": 800, "8st    ": 400, "9st    ": 200, "10st  ": 100}																																																   

var show_ads = false

var new_game = 0

var number_rect_size = null
var number_scene_pos = 0

func _ready():
#	print("_ready()")
	setup()


func setup_scenes():
	print("Main setup_scenes()")
#	SceneManager.set_scene(mainWindow_scene)
#	mainWindow = preload("res://Scripts/MainWindow.gd").new()
#	mainWindow.queue_resource(mainWindow_scene)
#	mainWindow.get_resource(mainWindow_scene).instance()
#	get_tree().get_root().add_scene(background_scene)
#	get_tree().get_root().get_node("/root").add_scene(gui_scene)


func setup_nodes():
	print("Main setup_nodes()")
	# сцены добавленные рукаи в облочке, добавляются как-то не так, не полностью, правильно работают только если добавлять в коде
	inputLagTimer = Timer.new()
	inputLagTimer.wait_time = 1.2
	inputLagTimer.one_shot = true
	inputLagTimer.name = "InputLagTimer"
	background_node = background_scene.instance()
	get_node("/root/MainWindow").add_child(background_node)
	background_node.set_visible(true)
	get_node("/root/MainWindow").add_child(inputLagTimer)
#   Had to change the get_node to get_tree().get_root().get_node()	
	gui_node = gui_scene.instance()
	get_node("/root/MainWindow").add_child(gui_node)
	gui_node.set_visible(false)
	gamefield_node = game_field_scene.instance()
	get_node("/root/MainWindow/GUI/VBoxC/GFContainer").add_child(gamefield_node)
	ads_node = ads_scene.instance()
	get_node("/root/MainWindow").add_child(ads_node)
	ads_node.set_visible(false)
	gui_gameover_node = gui_gameover_scene.instance()
	get_node("/root/MainWindow").add_child(gui_gameover_node)
	gui_gameover_node.set_visible(false)
	


#func setup_signals():
##	print("setup_signals()")
##	SignalManager.connect("gui_mm_start_new_game", self, "_on_GUI_start_new_game")
##	SignalManager.connect("gui_mm_options", self, "_on_GUI_options")
##	SignalManager.connect("gui_mm_help", self, "_on_GUI_help")
#	pass


#func _process(_delta):
#	#if	new_game != 0:
#		#print("_process(_delta)")
#		#touch_input()
#		#draw_field()
#	pass


func new_game():
	print("Main new_game()")
	randgen.randomize()
	background_node.set_visible(true)
	undo_game_field = null				   
	new_game = 1	
	game_field = make_matrix()
	summ = 0	
	current_score = summ
	fill_field_with_numbers()
	reasign_numbers_on_gamefield()
	gui_node.set_visible(true)
	gui_node.update_score()
#	gui_gameover_node.queue_free()
#	ads_node.queue_free()
	#inputLagTimer.start()
#	get_tree().change_scene()



func game_over():
	print("Main game_over()")
	undo_game_field = null				
	AdsManager.showRewardedVideo() 
	set_records_table() 
	if new_game == 1:
		print("Main game_over() do smthng")
		new_game = 0
		gui_node.set_visible(false)
		gui_gameover_node.update_score()
		gui_gameover_node.set_visible(true)


func setup():
	print("Main setup()")
	randgen.randomize()
	setup_scenes()
	setup_nodes()
	setup_window()
#	setup_signals()
#	setup_thems()	
	game_field = make_matrix()	
	call_deferred("create_gamefield_with_plates")
#	create_gamefield_with_plates()


func setup_thems():
	print("Main setup_thems()")


func update_score():
	current_score = summ
	if current_score >= best_score:
		best_score = current_score


func setup_window():
#	print("setup_window()")
	#set_size(get_tree().get_root().get_rect().size) 
	#screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
	#screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
	print(screenSize)
	game_window_width_x = screenSize.x
	game_window_heigth_y = screenSize.y
	game_field_width_x = game_window_width_x
	number_size = game_field_width_x / game_field_size
	number_rect_size = Vector2(number_size, number_size)


func set_records_table():
	# проверять значение current_score и вставлять его в словарь только в одну строку
	# для этого искать близкий по значению элемент либо просто запоминать количество меньших
	# и вставлять данные в последний элемент но для этого надо городить массивы данных
	# если у словаря есть индекс тогда все проще
	var value = 0
	for key in scores_dict:
		if scores_dict[key] as int <= current_score:			
#			scores_dict[key] = ["My Score"]
			scores_dict[key] = str(current_score)



func show_ads():
	print("Main show_ads()")
	show_ads = true
#	get_node("/root/MainWindow").rewardedvideo_show()
#	get_node("/root/MainWindow").interstitial_show()
	
#	ads_node.set_visible(true)
#	show_background_node(false)
#	background_node.set_visible(false)
#	show_ads_node(true)
#	ads_node.start_ads_timer()
	new_game()
	#$GUI.show_message("ADs, Money blwe $$$$$$$" )


func colors_thems(curr_color_them : String):
	if curr_color_them == "light":
		main_background_color ="73947A"
		plate_background_color ="5E7478"
		menu_machground = "A5B48C"
		text_color = "363636"
	elif curr_color_them == "dark":
		main_background_color ="011606"
		plate_background_color ="0C1618"
		menu_machground = "1D2411"
		text_color = "9E9E9E"
	else:
		return


func arr_copy(arr):
	return arr.duplicate(true)


func undo():	
	# не работает (( в 2584 рабоает здесь не работает (((
	if undo_game_field != null:
		game_field = arr_copy(undo_game_field)
	is_undo_copied = false	
	reasign_numbers_on_gamefield()
	AdsManager.showInterstitial()


func copy_gamefield():
	if is_undo_copied == false:
		undo_game_field = arr_copy(game_field)
	is_undo_copied = true
	

func ai_turns(turns:int):
	for i in range(turns):
		if new_game == 1:
			yield(get_tree().create_timer(0.01), "timeout")
			call_deferred("move_right",game_field)
			yield(get_tree().create_timer(0.01), "timeout")
			call_deferred("move_down",game_field)
			yield(get_tree().create_timer(0.01), "timeout")
			call_deferred("move_left",game_field)
			yield(get_tree().create_timer(0.01), "timeout")
			call_deferred("move_up",game_field)
		else:
			return


func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"screenSize_x" : screenSize.x, 
		"screenSize_y" : screenSize.y,
		"show_ads" : show_ads, 
		"best_score" : best_score, 
		"current_score" : current_score,
		"game_field" : game_field,
		"undo_game_field" : undo_game_field,
		"summ" : summ,
		"curr_color_them" : curr_color_them,
		"new_game_numbers" : new_game_numbers,
		"hard_level" : hard_level,
		"game_field_size" : game_field_size,
		"clickInput" : clickInput,
		"number_size" : number_size,
		"game_field_width_x" : game_field_width_x
	}
	return save_dict


func save_game():
# Note: This can be called from anywhere inside the tree. This function is
# path independent.
# Go through everything in the persist category and ask them to return a
# dict of relevant variables
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function
		var node_data = node.call("save")

		# Store the save dictionary as a new line in the save file
		save_game.store_line(to_json(node_data))
	save_game.close()


func load_game():
	# Note: This can be called from anywhere inside the tree. This function
# is path independent.
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():
		# Get the saved dictionary from the next line in the save file
		var node_data = parse_json(save_game.get_line())

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instance()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
	save_game.close()


func make_matrix():
#	print("make_2d_array()")
	var array = []
	for colx in game_field_size:
		array.append([])
		for rowy in game_field_size:
			array[colx].append(0)
	return array



func generate_new_numbers_in_array():
#	print("Main generate_new_numbers_in_array()")
	randgen.randomize()
	kodn = koldop
	while kodn > 0:
		#var y = int(ny * game_field_size % 1)	
		var colx = randgen.randi_range(0,game_field_size - 1)
		var rowy = randgen.randi_range(0,game_field_size - 1)	
		#print(rowy, colx)
		if game_field[rowy][colx] == 0:
			kodn = kodn - 1
			var num = randgen.randf()
			if num <= 0.72:
				game_field[rowy][colx] = number_one
				summ += number_one
			else:
				game_field[rowy][colx] = number_two
				summ += number_two	


func generate_stones_in_array():
#	print("Main generate_new_numbers_in_array()")
	var kodw=1
	while kodw == 1 :
		randgen.randomize()
	
		#var y = int(ny * game_field_size % 1)	
		var colx = randgen.randi_range(0,game_field_size - 1)
		var rowy = randgen.randi_range(0,game_field_size - 1)	
		#print(rowy, colx)
		if game_field[rowy][colx] == 0:
			kodw=0
						
			var num = randgen.randf()
			if summ > 32 and summ < 40 :
				summ +=8
									
				if num <= 0.618:
					game_field[rowy][colx] = -256
					sumb+=256
				else:
					game_field[rowy][colx] = -512
					sumb+=512
					
			elif summ > 1024 and summ < 1032 :
				summ +=8
		
					
				if num <= 0.618:
					game_field[rowy][colx] = -1024
					sumb+=1024
					
				else:
					game_field[rowy][colx] = -2048
					sumb+=2048
	
			
func create_gamefield_with_plates():
#	print("create_gamefield_with_plates()")
	for colx in range(game_field_size):
		for rowy in range(game_field_size):
			var curr_number = number_scene.instance()
			#$GUI/VBoxC/GFContainer/GameField/VBoxContainer/ColorRect			
			if game_field[rowy][colx] == 0:
				curr_number.set_xy(rowy, colx)
				curr_number.setup_number_rect(number_rect_size)
				curr_number.set_empty_number()
				curr_number.position.x = number_size * colx + game_field_margin * (colx + 1)
				curr_number.position.y = number_size * rowy + game_field_margin * (rowy + 1)
			else:
#				print("draw_field() %s " % game_field[rowy][colx] as String)
				curr_number.set_xy(rowy, colx)
				curr_number.setup_number_rect(number_rect_size)
				curr_number.set_number_to_label(game_field[rowy][colx])
				curr_number.position.x = number_size * colx + game_field_margin * (colx + 1)
				curr_number.position.y = number_size * rowy + game_field_margin * (rowy + 1)
			gamefield_node.add_child(curr_number)


func reasign_numbers_on_gamefield():
#	print("reasign_numbers_on_gamefield()")
	var children_mas_number_scene = gamefield_node.get_children()
	for colx in range(game_field_size):
		for rowy in range(game_field_size):
			#curr_number.window_size = $GameField.get_viewport().get_visible_rect().size
			
			for i in range(len(children_mas_number_scene)):
				if children_mas_number_scene[i].curry_row == rowy and children_mas_number_scene[i].currx_col == colx:
					if game_field[rowy][colx] == 0: 
						children_mas_number_scene[i].set_empty_number()
					else:
						children_mas_number_scene[i].set_number_to_label(game_field[rowy][colx])	
					if children_mas_number_scene[i].number == 2048:
						call_deferred("do_graz_2048")
					if children_mas_number_scene[i].number == 204800:
						call_deferred("do_graz_adsoff")
	gui_node.update_score()

func check_space_for_numbers():
#	print("Main blank_space_on_board()")
	var space = 0
	for colx in game_field_size:
		for rowy in game_field_size:
			if game_field[rowy][colx] == null or game_field[rowy][colx] == 0:
				space += 1
	if space >= 2:
		return true
	elif space < 4:
		kodn = 0
	else:
		return false

func fill_field_with_numbers():
	if check_space_for_numbers():
		generate_new_numbers_in_array()
		
		if kodurv > 2:
			generate_stones_in_array()
		
	else:
		game_over()
		
func fibn(k):
	if k == 1:
		 return 0
	if k == 2:
		return 1
	var sc = 0
	var sa = 1
	var sb = 2
	var n = 1
	while k > sc:
		n += 1
		var c = sa + sb
		var a = sb
		sb = sc
	return n


# функции для динамического расчета палитры плашек под числами
#static bool IsFib(long T, out long idx)
#{
#    double root5 = Math.Sqrt(5);
#    double phi = (1 + root5) / 2;
#
#    idx    = (long)Math.Floor( Math.Log(T*root5) / Math.Log(phi) + 0.5 );
#    long u = (long)Math.Floor( Math.Pow(phi, idx)/root5 + 0.5);
#
#    return (u == T);
#}

#var
#  N, F1, F2, K: integer;
#Порядковый номер числа Фибоначчи
#begin
#  write('N = ');
#  readln(N);
#  F1 := 1; { <== первый член ряда Фибоначчи }
#  F2 := 1; { <== второй член ряда Фибоначчи }
#  K := 2;
#  { Выполняем цикл до тех пор, пока введенное нами 
#  число N больше очередного члена ряда Фибоначчи: }
#  while (N > F2) do
#  begin
#    F2 := F1 + F2; { <== новое значение F2 }
#    F1 := F2 - F1; { <== новое значение F1 }
#    inc(K) { <== увеличиваем номер члена F2 }
#  end;
#  writeln;
#  if N = F2 then writeln('Порядковый номер числа Фибоначчи: ', K)
#  else writeln(' ', N, ' не является числом Фибоначчи!');
#  readln
#end.

#var
#  N, F1, F2, c: integer;
#Соседние числа Фибоначчи
#begin
#  write('N = ');
#  readln(N);
#  F1 := 1; { <== первый член ряда Фибоначчи }
#  F2 := 1; { <== второй член ряда Фибоначчи }
#  { Выполняем цикл до тех пор, пока введенное нами 
#  число N больше очередного члена ряда Фибоначчи: }
#  while (N > F2) do
#  begin
#    c := F2; { <== запоминаем второй член ряда }
#    F2 := F1 + F2; { <== находим новое значение F2 }
#    F1 := c { <== первому члену приписываем предыдущий (c=F1) }
#  end;
#  if N = F2 then writeln('Соседние числа Фибоначчи: ', F1, ' ', F1+F2)
#  else writeln(N, ' не является числом Фибоначчи!');
#  readln
#end.


func do_graz_2048():
	print("pozdr s 2048")
	# играть музыку играть фонариками запускать фейерверки 


func do_graz_adsoff():
	print("pozdr s 7778742049 no ads for you")
	# играть музыку играть фонариками запускать фейерверки 



func show_gui_node(bl:bool):
	print("Main show_gui_node")
	if gui_node != null:
		gui_node.set_visible(bl)


func show_ads_node(bl:bool):
	print("Main show_ads_node")
	if ads_node != null:
		ads_node.set_visible(bl)


func show_gameover_node(bl:bool):
	print("Main show_gameover_node")
	if gui_gameover_node != null:
		gui_gameover_node.set_visible(bl)


func show_background_node(bl:bool):
	print("Main show_background_node")
	if background_node != null:
		background_node.set_visible(bl)



func move_down(mas):
#	print("func move_down(mas)")
	randgen.randomize()
	copy_gamefield()
	var kodx1 = 1
	while kodx1 == 1:
		var sempty = 0
		for colx in range(game_field_size):
			
			for rowy in range(game_field_size-1):
				
				if mas[rowy][colx] != 0:
					if mas[rowy+1][colx] == 0:
						kodx1 += 1
						mas[rowy+1][colx] = mas[rowy][colx]
						mas[rowy][colx] = 0
					elif abs(mas[rowy+1][colx]) == abs(mas[rowy][colx]) :
						kodx1 += 1
						mas[rowy+1][colx] = mas[rowy][colx]+mas[rowy+1][colx]
						mas[rowy][colx] = 0
				else:
					sempty += 1					
		if kodx1 > 1:
			kodx1 = 1
		else:
			kodx1 = 0
			if sempty == 0:
				# после окончания игры прододжает выполнять fill_field_with_numbers()
				update_score()
				game_over()
				return
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			fill_field_with_numbers()
	if gui_node != null && new_game != 0:
		reasign_numbers_on_gamefield()
	update_score()
	is_undo_copied = false				   

func move_up(mas):
#	print("func move_up(mas)")
	randgen.randomize()
	copy_gamefield()
	var kodx2 = 1
	while kodx2 == 1:
		var sempty = 0
		for colx in range(game_field_size):
			
			for rowy in range(1, game_field_size):
				
				if mas[game_field_size-rowy][colx] != 0:
					if  mas[game_field_size-rowy-1][colx] == 0:
						kodx2+=1
						mas[game_field_size-rowy-1][colx] =  mas[game_field_size-rowy][colx]
						mas[game_field_size-rowy][colx] = 0
					elif  abs(mas[game_field_size-rowy-1][colx]) == abs(mas[game_field_size-rowy][colx]) :
						kodx2+=1
						mas[game_field_size-rowy-1][colx] =  mas[game_field_size-rowy-1][colx]+ mas[game_field_size-rowy][colx]
						mas[game_field_size-rowy][colx] = 0
			
				else:
					sempty += 1

		if kodx2 > 1:
			kodx2 = 1
		else:
			kodx2 = 0
			if sempty == 0:
				update_score()
				game_over()
				return
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			fill_field_with_numbers()
	if gui_node != null && new_game != 0:
		reasign_numbers_on_gamefield()
	update_score()
	is_undo_copied = false				   
	
func move_right(mas):
#	print("func move_right(mas)")
	randgen.randomize()
	copy_gamefield()
	var kody1 = 1
	while kody1 == 1:
		var sempty = 0
		for rowy in range(game_field_size):
			
			for colx in range(game_field_size-1):
				
				if mas[rowy][colx] != 0:
					if mas[rowy][colx+1] == 0:
						kody1+=1
						mas[rowy][colx+1] = mas[rowy][colx]
						mas[rowy][colx] = 0
					elif abs(mas[rowy][colx+1]) == abs(mas[rowy][colx]) :
						kody1+=1
						mas[rowy][colx+1] = mas[rowy][colx+1]+mas[rowy][colx]
						mas[rowy][colx] = 0	
				else:
					sempty += 1					
		if kody1 > 1:
			kody1 = 1
		else:
			kody1 = 0
			if sempty == 0:
				update_score()
				game_over()
				return
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			fill_field_with_numbers()
	if gui_node != null && new_game != 0:
		reasign_numbers_on_gamefield()
	update_score()
	is_undo_copied = false				   

func move_left(mas):
#	print("func move_left(mas)")
	randgen.randomize()
	copy_gamefield()
	var kody2 = 1
	while kody2 == 1:
		var sempty = 0
		for rowy in range(game_field_size):
			
			for colx in range(1, game_field_size):
				
				if mas[rowy][game_field_size-colx] != 0:
					if mas[rowy][game_field_size-colx-1]== 0:
						kody2+=1
						mas[rowy][game_field_size-colx-1] =  mas[rowy][game_field_size-colx]
						mas[rowy][game_field_size-colx] = 0
					elif  abs(mas[rowy][game_field_size-colx-1]) ==  abs(mas[rowy][game_field_size-colx]) :
						kody2+=1
						mas[rowy][game_field_size-colx-1] = mas[rowy][game_field_size-colx-1] + mas[rowy][game_field_size-colx]
						mas[rowy][game_field_size-colx] =  0
				else:
					sempty += 1
											
		if kody2 > 1:
			kody2 = 1
		else:
			kody2 = 0
			if sempty == 0:
				update_score()
				game_over()
				return
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			fill_field_with_numbers()
	if gui_node != null && new_game != 0:
		reasign_numbers_on_gamefield()
	update_score()
	is_undo_copied = false				   
