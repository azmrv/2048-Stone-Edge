extends Node2D


signal gui_go_exit_to_menu_button
signal gui_go_new_game

var screenSize = Vector2(0,0)
#var background_scenes = preload("res://Scenes/Background.tscn")


func _ready() -> void:
	setup()

#
#func _process(delta: float) -> void:
#	if $WaitForADs.get_time_left() != 0:
#		$PopUp/TimeToADs.text = str($WaitForADs.time_left)



func setup():
	print("GUI_GameOver setup()")
#	screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
#	screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
#	self.rect_min_size = screenSize
#	var background_node = background_scenes.instance()
#	self.add_child(background_node)	
#	background_node.set_visible(true)
#	Main.gui_gameover_node.set_visible(true)
	$VBox.rect_min_size = screenSize	
	print("set screen size = %s" %  screenSize)
#	$WaitForADs.connect("timeout", self, "_on_WaitForADs_timeout")
	

func update_score():
#	print("GUI_GameOver update_score(score)")
#	$VBox/VBoxLabels/ScoreTable.text = "Score: %s" % str(Main.current_score) 
	$VBox/VBoxLabels/ScoreTable.bbcode_text = "[center]Score Table" + "\n" +"[/center]"
	Main.set_records_table()
	var dict = Main.scores_dict	
	for key in dict:
		$VBox/VBoxLabels/ScoreTable.append_bbcode("		" + str(key)+": "+ str(dict[key]) + "\n")

func _on_NewGame_pressed() -> void:
#	$VBox.visible = false
#	$PopUp.visible = true
	Main.gui_gameover_node.set_visible(false)
	AdsManager.showInterstitial()
	Main.new_game()

#	$WaitForADs.wait_time = 0.3
#	$WaitForADs.one_shot = true
#	$WaitForADs.start()

func _on_WaitForADs_timeout() -> void:
	$PopUp.visible = false
	$VBox.visible = true
	Main.gui_gameover_node.set_visible(false)
	
