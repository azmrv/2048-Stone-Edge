extends Node

# Const
const COMMON_SAVEDATA = "user://savegame.save"
const SCORE_TABLE_SAVEDATA = "user://scores.save"
const GAMEFIELD_SAVEDATA = "user://gamefield.save"



func load_game():
	load_from_file(COMMON_SAVEDATA, json_node_save())
	load_from_file(SCORE_TABLE_SAVEDATA, Main.scores_dict)
	load_from_file(GAMEFIELD_SAVEDATA, Main.game_field)


func save_game():
	save_to_file(COMMON_SAVEDATA, json_node_save())
	save_to_file(SCORE_TABLE_SAVEDATA, Main.scores_dict)
	save_to_file(GAMEFIELD_SAVEDATA, Main.game_field)


func save_to_file(filepath, save_object):
	var file = File.new()
	file.open(filepath, File.WRITE)
	file.store_var(save_object, true)
	file.close()


func check_saves():
	var file = File.new()	
	if file.file_exists(COMMON_SAVEDATA) and file.file_exists(SCORE_TABLE_SAVEDATA) and file.file_exists(GAMEFIELD_SAVEDATA):
		return true
	else:
		return false


func load_from_file(filepath, load_object):
	var file = File.new()
	if file.file_exists(filepath):
		file.open(filepath, File.READ)
		load_object = file.get_var(true)
		file.close()


func json_node_save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
#		"screenSize_x" : Main.screenSize.x, 
#		"screenSize_y" : Main.screenSize.y,
#		"show_ads" : Main.show_ads, 
#		"best_score" : Main.best_score, 
#		"current_score" : Main.current_score,
#		"game_field" : Main.game_field,
#		"undo_game_field" : Main.undo_game_field,
#		"summ" : Main.summ,
#		"curr_color_them" : Main.curr_color_them,
#		"new_game_numbers" : Main.new_game_numbers,
#		"hard_level" : Main.hard_level,
#		"game_field_size" : Main.game_field_size,
#		"clickInput" : Main.clickInput,
#		"number_size" : Main.number_size,
#		"game_field_width_x" : Main.game_field_width_x
	}
	return save_dict


func save_node_json_game():
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


func load_node_json_game():
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




func max_dict_to(dict, val):
	var max_var = 0
	var max_val = 0
	for i in dict:
		if val > dict[i]:
			max_val = val
			max_var = i
	return max_var


func min_dict_to(dict, val):
	var min_var = 0
	var min_val = 0
	for i in dict:
		if val < dict[i]:
			min_val = val
			min_var = i
	return min_var	


func max_dict_val(dict):
	var max_var = 0
	var max_val = 0
	for i in dict:
		var val = dict[i]
		if val > dict[i]:
			max_val = val
			max_var = i
	return max_var


func min_dict_val(dict):
	var min_var = 0
	var min_val = 0
	for i in dict:
		var val = dict[i]
		if val < dict[i]:
			min_val = val
			min_var = i
	return min_var	


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
