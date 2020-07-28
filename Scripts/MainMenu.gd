extends Node2D


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
var background_scenes = preload("res://Scenes/Background.tscn")

# GUI Scenes
var gui_scene = preload("res://Scenes/GUI.tscn")
var gui_gameover_scene = preload("res://Scenes/GUI_GameOver.tscn")

#Nodes
#var inputLagTimer = null
#var gui_node = null
#var ads_node = null
#var gui_gameover_node = null
#var background_node = null
	
	
var screenSize = Vector2(0,0)
var game_window_width_x = 500
var game_window_heigth_y = 800
var game_window_margin = 0

var game_field_width_x = 500
var game_field_margin = 0

var number_size = 80

var clickInput = false

var first_touch = Vector2(0, 0)
var final_touch = Vector2(0, 0)
var swipe_start = null
var minimum_drag = 100
var swipe = null

const game_field_size = 5 

var hard_level = 3
var iq_level = 0
var new_game_numbers = 3

var curr_color_them = "light"
var main_background_color ="73947A"
var plate_background_color ="5E7478"
var menu_machground = "A5B48C"
var text_color = "363636"

var summ = 0
var eend = 4
var koldop = 2

# for testing old value = 1, 2
var number_one = 123456
var number_two = 123456
var number_three = 3
var number_four = 4
var number_five = 5

var undo_game_field = [[],[]]
var game_field = [[],[]]

var randgen = RandomNumberGenerator.new()

var current_score = 0
var total_score = 0
var best_score = 0

var show_ads = false

var new_game = 0

var number_rect_size = null
var number_scene_pos = 0

func _ready():
	print("_ready()")
	setup()
	new_game()




func setup_scenes():
	print("setup_scenes()")
#	background_node = background_scenes.instance()
#	gui_node = gui_scene.instance()
#	ads_node = ads_scene.instance()
#	gui_gameover_node = gui_gameover_scene.instance()
#	background_node = $Background
#	gui_node = $GUI
#	ads_node = $ADs
#	gui_gameover_node = $GUI_GameOver
#	Scenes
	number_scene = preload("res://Scenes/Number.tscn")
	ads_scene = preload("res://Scenes/ADs.tscn")
	gamefield_scene = preload("res://Scenes/GameField.tscn")
	background_scenes = preload("res://Scenes/Background.tscn")

# 	GUI Scenes
	gui_scene = preload("res://Scenes/GUI.tscn")
	gui_gameover_scene = preload("res://Scenes/GUI_GameOver.tscn")
	
func setup_nodes():
	print("setup_nodes()")
	# сцены добавленные рукаи в облочке, добавляются как-то не так, не полностью, правильно работают только если добавлять в коде
#	inputLagTimer = Timer.new()
#	inputLagTimer.wait_time = 1.2
#	inputLagTimer.one_shot = true
#	inputLagTimer.name = "InputLagTimer"
#	self.add_child(inputLagTimer)
#   Had to change the get_node to get_tree().get_root().get_node()
	
#	show_gui_node(false)
	
#	show_gameover_node(false)

#	show_ads_node(false)
	

func setup_signals():
	print("setup_signals()")
#	gui_scene.connect("gui_mm_start_new_game", self, "_on_GUI_start_new_game")
#	gui_scene.connect("gui_mm_options", self, "_on_GUI_options")
#	gui_scene.connect("gui_mm_help", self, "_on_GUI_help")

func _process(_delta):
	#if	new_game != 0:
		#print("_process(_delta)")
		#touch_input()
		#draw_field()
	pass

func new_game():
	print("new_game()")
	randgen.randomize()
	setup()
#	self.add_child(background_node)
#	show_background_node(true)
#	self.add_child(gui_node)	
#	gui_gameover_node.free()
	game_field = make_matrix()
	summ = 0
	create_numbers_on_game_field()
	fill_field_with_numbers()
	reasign_numbers_to_field()
	#inputLagTimer.start()
	new_game = 1
	show_gui_node(true)
	
	
func game_over():	
	print("game_over()")
	setup()
	show_gui_node(false)
#	self.add_child(gui_gameover_node)
#	background_node.free()
#	gui_node.free()
	
	new_game = 0
	randgen.randomize()	
#	$GUI/VBoxC/GFContainer/GameField.get_children().clear()	
#	$GUI.update_score(summ)
	show_gameover_node(true)
	
func setup():
	print("setup()")
	randgen.randomize()
	setup_scenes()
#	setup_nodes()
	setup_window()
	setup_signals()
#	setup_thems()

func setup_thems():
	print("setup_thems()")	


func setup_window():
	print("setup_window()")
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

func show_ads():
	print("show_ads()")
	show_ads = true
#	self.add_child(ads_node)
#	show_gameover_node(false)
#	show_background_node(false)
	show_ads_node(true)
	$ADs.start_ads_timer()
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

func undo(lever:bool):
	$GUI/VBoxC/Menu/VBox/Buttons/Undo.disabled = true
	show_ads()
	if lever == true:
		game_field = undo_game_field
	else:
		$GUI/VBoxC/Menu/VBox/Buttons/Undo.disabled = false

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
		"swipe" : swipe,
		"minimum_drag" : minimum_drag,
		"swipe_start" : swipe_start,
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
	print("make_2d_array()")
	var array = []
	for colx in game_field_size:
		array.append([])
		for rowy in game_field_size:
			array[colx].append(null)
	return array

func generate_new_numbers_in_array():
	print("generate_new_numbers_in_array()")
	randgen.randomize()
	var kodn = koldop
	while kodn > 0:
		#var nx = randgen.randf()
		#var ny = randgen.randf()
		#var x = int(nx * game_field_size % 1)
		#var y = int(ny * game_field_size % 1)
		# вот теперь не зависает в этом месте при попытке разместить числа на поле доп проверка на свободное место
		if blank_space_on_board():
			var colx = randgen.randi_range(0,game_field_size - 1)
			var rowy = randgen.randi_range(0,game_field_size - 1)
			#print(rowy, colx)
			if game_field[rowy][colx] == null:
				kodn = kodn - 1
				var num = randgen.randf()
				if num <= 0.618:
					game_field[rowy][colx] = number_one
					summ += 1
				else:
					game_field[rowy][colx] = number_two
					summ += 2
	#			if num <= 0.5:
	#				game_field[rowy][colx] = 1
	#				summ += 1
	#			elif num <= 0.8:
	#				game_field[rowy][colx] = 2
	#				summ += 2
	#			else:
	#				game_field[rowy][colx] = 3
	#				summ += 3	
		else:
			return

func blank_space_on_board():
	#print("blank_space_on_board()")
	for colx in game_field_size:
		for rowy in game_field_size:
			if game_field[rowy][colx] == null or game_field[rowy][colx] == 0:
				return true
	return false

func fill_field_with_numbers():
	print("fill_board()")
	if blank_space_on_board():
		generate_new_numbers_in_array()
	else:
		game_over()

func create_numbers_on_game_field():
	print("create_numbers_on_game_field()")
	randgen.randomize()
	for colx in range(game_field_size):
		for rowy in range(game_field_size):
			var curr_number = number_scene.instance()
			#$GUI/VBoxC/GFContainer/GameField/VBoxContainer/ColorRect
			get_node("GUI/VBoxC/GFContainer/GameField").add_child(curr_number)
			if game_field[rowy][colx] == null:
				curr_number.set_xy(rowy, colx)
				curr_number.setup_number_rect(number_rect_size)
				curr_number.set_number_text("")
				curr_number.position.x = number_size * colx + game_field_margin * (colx + 1)
				curr_number.position.y = number_size * rowy + game_field_margin * (rowy + 1)
			else:
				print("draw_field() %s " % game_field[rowy][colx] as String)
				curr_number.set_xy(rowy, colx)
				curr_number.setup_number_rect(number_rect_size)
				curr_number.set_number_to_label(game_field[rowy][colx])
				curr_number.position.x = number_size * colx + game_field_margin * (colx + 1)
				curr_number.position.y = number_size * rowy + game_field_margin * (rowy + 1)

func reasign_numbers_to_field():
	print("reasign_numbers_to_field()")
	randgen.randomize()
	for colx in range(game_field_size):
		for rowy in range(game_field_size):
			#curr_number.window_size = $GameField.get_viewport().get_visible_rect().size
			var children_mas_number_scene =  $GUI/VBoxC/GFContainer/GameField.get_children()
			for i in range(len(children_mas_number_scene)):
				if children_mas_number_scene[i].curry_row == rowy and children_mas_number_scene[i].currx_col == colx:
					if game_field[rowy][colx] == null: 
						children_mas_number_scene[i].set_number_text("")
					else:
						children_mas_number_scene[i].set_number_to_label(game_field[rowy][colx])	
	$GUI.update_score(summ)

func move_down(mas):
	print("func move_down(mas)")
	randgen.randomize()
	undo_game_field = mas
	var kodx1 = 1
	while kodx1 == 1:
		var sempty = 0
		for colx in range(game_field_size):
			
			for rowy in range(game_field_size-1):
				
				if mas[rowy][colx] != null:
					if mas[rowy+1][colx] == null:
						kodx1 += 1
						mas[rowy+1][colx] = mas[rowy][colx]
						mas[rowy][colx] = null
					elif mas[rowy+1][colx] == 1:
						if mas[rowy][colx] == 1 or mas[rowy][colx] == 2:
							kodx1 += 1
							mas[rowy+1][colx] = mas[rowy+1][colx]+mas[rowy][colx]
							mas[rowy][colx] = null
					elif mas[rowy+1][colx] > mas[rowy][colx] and mas[rowy+1][colx] <= 2 * mas[rowy][colx]:
						kodx1 += 1
						mas[rowy+1][colx] = mas[rowy+1][colx]+mas[rowy][colx]
						mas[rowy][colx] = null
					elif mas[rowy+1][colx] < mas[rowy][colx] and mas[rowy][colx] <= 2 * mas[rowy+1][colx]:
						kodx1 += 1
						mas[rowy+1][colx] = mas[rowy+1][colx]+mas[rowy][colx]
						mas[rowy][colx] = null
				else:
					sempty += 1					
		if kodx1 > 1:
			kodx1 = 1
		else:
			kodx1 = 0
			if sempty == 0:
				game_over()
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			fill_field_with_numbers()
	reasign_numbers_to_field()

func move_up(mas):
	print("func move_up(mas)")
	randgen.randomize()
	undo_game_field = mas
	var kodx2 = 1
	while kodx2 == 1:
		var sempty = 0
		for colx in range(game_field_size):
			
			for rowy in range(1, game_field_size):
				
				if mas[game_field_size-rowy][colx] != null:
					if  mas[game_field_size-rowy-1][colx] == null:
						kodx2+=1
						mas[game_field_size-rowy-1][colx] =  mas[game_field_size-rowy][colx]
						mas[game_field_size-rowy][colx] = null
					elif  mas[game_field_size-rowy-1][colx] == 1:
						if  mas[game_field_size-rowy][colx] == 1 or  mas[game_field_size-rowy][colx] == 2:
							kodx2+=1
							mas[game_field_size-rowy-1][colx] = mas[game_field_size-rowy-1][colx]+ mas[game_field_size-rowy][colx]
							mas[game_field_size-rowy][colx] = null
					elif  mas[game_field_size-rowy-1][colx] > mas[game_field_size-rowy][colx]  and  mas[game_field_size-rowy-1][colx] <= 2 * mas[game_field_size-rowy][colx] :
						kodx2+=1
						mas[game_field_size-rowy-1][colx] =  mas[game_field_size-rowy-1][colx]+ mas[game_field_size-rowy][colx]
						mas[game_field_size-rowy][colx] = null
					elif  mas[game_field_size-rowy-1][colx] <  mas[game_field_size-rowy][colx] and  mas[game_field_size-rowy][colx] <= 2 *  mas[game_field_size-rowy-1][colx]:
						kodx2+=1
						mas[game_field_size-rowy-1][colx] =  mas[game_field_size-rowy-1][colx] +  mas[game_field_size-rowy][colx]
						mas[game_field_size-rowy][colx] = null
				else:
					sempty += 1

		if kodx2 > 1:
			kodx2 = 1
		else:
			kodx2 = 0
			if sempty == 0:
				game_over()
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			fill_field_with_numbers()
	reasign_numbers_to_field()

func move_right(mas):
	print("func move_right(mas)")
	randgen.randomize()
	undo_game_field = mas
	var kody1 = 1
	while kody1 == 1:
		var sempty = 0
		for rowy in range(game_field_size):
			
			for colx in range(game_field_size-1):
				
				if mas[rowy][colx] != null:
					if mas[rowy][colx+1] == null:
						kody1+=1
						mas[rowy][colx+1] = mas[rowy][colx]
						mas[rowy][colx] = null
					elif mas[rowy][colx+1] == 1:
						if mas[rowy][colx] == 1 or mas[rowy][colx] == 2:
							kody1+=1
							mas[rowy][colx+1] = mas[rowy][colx+1]+mas[rowy][colx]
							mas[rowy][colx] = null
					elif mas[rowy][colx+1] > mas[rowy][colx] and mas[rowy][colx+1] <= 2 * mas[rowy][colx]:
						kody1+=1
						mas[rowy][colx+1] = mas[rowy][colx+1]+mas[rowy][colx]
						mas[rowy][colx] = null
					elif mas[rowy][colx+1] < mas[rowy][colx] and mas[rowy][colx] <= 2 * mas[rowy][colx+1]:
						kody1+=1
						mas[rowy][colx+1] = mas[rowy][colx+1]+mas[rowy][colx]
						mas[rowy][colx] = null	
				else:
					sempty += 1					
		if kody1 > 1:
			kody1 = 1
		else:
			kody1 = 0
			if sempty == 0:
				game_over()
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			fill_field_with_numbers()
	reasign_numbers_to_field()	

func move_left(mas):
	print("func move_left(mas)")
	randgen.randomize()
	undo_game_field = mas
	var kody2 = 1
	while kody2 == 1:
		var sempty = 0
		for rowy in range(game_field_size):
			
			for colx in range(1, game_field_size):
				
				if mas[rowy][game_field_size-colx] != null:
					if mas[rowy][game_field_size-colx-1]== null:
						kody2+=1
						mas[rowy][game_field_size-colx-1] =  mas[rowy][game_field_size-colx]
						mas[rowy][game_field_size-colx] = null
					elif mas[rowy][game_field_size-colx-1]  == 1:
						if  mas[rowy][game_field_size-colx] == 1 or  mas[rowy][game_field_size-colx] == 2:
							kody2+=1
							mas[rowy][game_field_size-colx-1] = mas[rowy][game_field_size-colx-1] + mas[rowy][game_field_size-colx]
							mas[rowy][game_field_size-colx] = null
					elif  mas[rowy][game_field_size-colx-1] >  mas[rowy][game_field_size-colx] and  mas[rowy][game_field_size-colx-1] <= 2 * mas[rowy][game_field_size-colx]  :
						kody2+=1
						mas[rowy][game_field_size-colx-1] = mas[rowy][game_field_size-colx-1] + mas[rowy][game_field_size-colx]
						mas[rowy][game_field_size-colx] =  null
						
					elif  mas[rowy][game_field_size-colx-1] < mas[rowy][game_field_size-colx] and  mas[rowy][game_field_size-colx] <= 2 * mas[rowy][game_field_size-colx-1] :
						kody2+=1
						mas[rowy][game_field_size-colx-1] = mas[rowy][game_field_size-colx-1] + mas[rowy][game_field_size-colx]
						mas[rowy][game_field_size-colx] =  null
				else:
					sempty += 1
											
		if kody2 > 1:
			kody2 = 1
		else:
			kody2 = 0
			if sempty == 0:
				game_over()
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			fill_field_with_numbers()
	reasign_numbers_to_field()

func _input(event):
	if (new_game != 0) && (clickInput == true):
		#print("_input(event)", event)
		if(Input.is_action_just_pressed("ui_touch")):
			print("_input(event) - (Input.is_action_just_PREssed(ui_touch))")
			first_touch = (get_global_mouse_position())
		if(Input.is_action_just_released("ui_touch")):
			print("_input(event) - (Input.is_action_just_REleased(ui_touch))")
			final_touch = (get_global_mouse_position())
			calculate_direction()
	elif (new_game != 0) && (clickInput == false):
		if event is InputEventScreenTouch:
			if event.pressed:
			  swipe_start = event.get_position()
			else:
			  _calculate_swipe(event.get_position())

func _unhandled_input(event):
	if (new_game != 0) && (clickInput == false):
		if event is InputEventScreenTouch:
			if event.pressed:
			  swipe_start = event.get_position()
			else:
			  _calculate_swipe(event.get_position())

func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			move_right(game_field)
		if swipe.x < 0:
			move_left(game_field)
	if abs(swipe.y) > minimum_drag:
		if swipe.y > 0:
			move_down(game_field)
		if swipe.y < 0:
			move_up(game_field)

func calculate_direction():
	var k_scr = (game_window_heigth_y - game_window_width_x)/2
	print("calculate_direction()")
	print("y =", final_touch.y, " x =", final_touch.x)	
	if final_touch.x > final_touch.y-k_scr:		
		if final_touch.x + final_touch.y-k_scr < game_window_width_x:
			move_up(game_field)
		else:
			move_right(game_field)
	else:
		if final_touch.x + final_touch.y-k_scr < game_window_width_x:
			move_left(game_field)
		else:
			move_down(game_field) 

func show_gui_node(bl:bool):	
	print("show_gui_node")
	# If one does not wish to fail these checks without notifying users, one
	# can use an assert instead. These will trigger runtime errors
	# immediately if not true.
	#assert(child.has("set_visible"))
	#assert(child.is_in_group("offer"))
	#assert(child is CanvasItem)
	#assert(gui_node.has("set_visible"))
#	gui_node.set_visible(bl)
	$GUI.visible = bl

func show_ads_node(bl:bool):
	print("show_ads_node")
	#assert(ads_node.has("set_visible"))
#	if ads_node != null:
#		ads_node.set_visible(bl)
	$ADs.visible = bl

func show_gameover_node(bl:bool):
	print("show_gameover_node")
	#assert(gui_gameover_node.has("set_visible"))
#	if gui_gameover_node != null:
#		gui_gameover_node.set_visible(bl)
	$GUI_GameOver.visible = bl

func show_background_node(bl:bool):
	print("show_background_node")
	#assert(gui_gameover_node.has("set_visible"))
#	if background_node != null:
#		background_node.set_visible(bl)	
	$Background.visible = bl
