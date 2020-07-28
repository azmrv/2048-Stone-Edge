extends Node2D

signal gui_start_new_game
signal gui_exit_to_menu
signal gui_help
signal gui_options
signal gui_psyontech
signal gui_undo

var background_scenes = preload("res://Scenes/Background.tscn")

var screenSize = Vector2(0,0)
var showMenuLag = null

var game_field

func _ready() -> void:
	print("GUI ready()")	
	setup()
	setup_signals()
	setup_nodes()
	add_menu_items()
	

func setup_nodes():
	showMenuLag = Timer.new()
	showMenuLag.wait_time = 1.2
	showMenuLag.one_shot = true
	showMenuLag.name = "ShowMenuLag"
	self.add_child(showMenuLag)

	
#Description
#Dialog for confirmation of actions. This dialog inherits from AcceptDialog, but has by default an OK and Cancel button (in host OS order).
#
#To get cancel action, you can use:
#
#get_cancel().connect("pressed", self, "cancelled").


func setup():
	print("GUI setup()")
#	screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
#	screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
#	self.rect_min_size = screenSize
#	var background_node = background_scenes.instance()
#	self.add_child(background_node)
	Main.gui_node.set_visible(true)
	$VBoxC.rect_min_size = screenSize
#	create_numbers_on_game_field()
	print("set screen size = %s" %  screenSize)


func add_menu_items():
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("New Game",1)#	
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("5 x 5",5))
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("8 x 8",8)
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("Share",10)
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("Toggle Click Mode",2)
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("Change Theme",3)
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("Toggle AI",13)
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("Options",9)
	pass


func show_message(text):
#	print("show_message()")
#	$GUI_InGamePlay/VBoxContainer/CentContMessage/Message.text = text
#	$GUI_InGamePlay/VBoxContainer/CentContMessage/Message.show()
#	$GUI_InGamePlay/MessageTimer.start()
	pass


func show_game_over():
#	show_message("Game Over")
#	# Wait until the MessageTimer has counted down.
#	yield($GUI_InGamePlay/MessageTimer, "timeout")
#
#	show_message("Try Again!")
#	# Wait until the MessageTimer has counted down.
#	yield($GUI_InGamePlay/MessageTimer, "timeout")
#
#	$GUI_InGamePlay/Message.text = "Fibonacci!"
#	$GUI_InGamePlay/Message.show()
#	# Make a one-shot timer and wait for it to finish.
#	yield(get_tree().create_timer(1), "timeout")
#
#	$GUI_MainMenu/CenterContainer2/VBoxContainer/ExitGame.show()
#	$GUI_MainMenu/CenterContainer2/VBoxContainer/StartGame.show()
	pass


func update_score():
#	print("GUI update_score(score)")
	$VBoxC/Menu/VBox/Score/Score.text = "Score: %s" % str(Main.current_score)
	$VBoxC/Menu/VBox/Score/Best.text = "Best: %s" % str(Main.best_score)    


func setup_signals():
#	print("setup_signals()")
	pass





func _on_Psyontech_pressed() -> void:
	emit_signal("gui_psyontech")
	AdsManager.show()
	OS.shell_open("http://games.psyon.tech/")


func _on_Undo_pressed() -> void:
	emit_signal("gui_undo")	
	AdsManager.showInterstitial()
	Main.undo()


func _on_MenuB_pressed() -> void:
	Main.new_game = 0

	$Menu.show()


func _on_Restart_pressed() -> void:
	Main.new_game = 1
	update_score()
	AdsManager.showBanner()	
	Main.new_game()
	$Menu.hide()


func _on_8x8_pressed() -> void:
	Main.new_game = 1
	$Menu.hide()


func _on_5x5_pressed() -> void:
	Main.new_game = 1
	$Menu.hide()


func _on_ToggleTheme_pressed() -> void:
	if Main.is_dark == false && $Menu/CRect/CenterContainer/VBox/ToggleTheme.pressed == false:
		$Menu/CRect/CenterContainer/VBox/ToggleTheme.pressed = false
		$Menu/CRect/CenterContainer/VBox/ToggleTheme.text = "Dark"
		Main.is_dark = true	
		print("Mode %s" % Main.clickInput)
	if Main.is_dark == true && $Menu/CRect/CenterContainer/VBox/ToggleTheme.pressed == true:
		$Menu/CRect/CenterContainer/VBox/ToggleTheme.pressed = true
		$Menu/CRect/CenterContainer/VBox/ToggleTheme.text = "Bright"
		Main.is_dark = false
		print("Mode %s" % Main.clickInput)


func _on_ClickMode_pressed() -> void:
	print("GUI Change click mode")	
	if Main.clickInput == true && $Menu/CRect/CenterContainer/VBox/ClickMode.pressed == false:
		$Menu/CRect/CenterContainer/VBox/ClickMode.text = "Click Mode OFF"
		Main.clickInput = false		
		print("Mode %s" % Main.clickInput)
	elif Main.clickInput == false && $Menu/CRect/CenterContainer/VBox/ClickMode.pressed == true:
		$Menu/CRect/CenterContainer/VBox/ClickMode.text = "Click Mode ON"
		Main.clickInput = true
		print("Mode %s" % Main.clickInput)
	


func _on_Options_pressed() -> void:
	Main.new_game = 1
	$Menu.hide()


func _on_AI_pressed() -> void:
	Main.new_game = 1
	$Menu/CRect/CenterContainer/VBox/AI.text = "10 turns AI"
	$Menu.hide()
	Main.ai_turns(20)
	


func _on_Share_pressed() -> void:
	Main.new_game = 1
	$Menu.hide()


func _on_Close_pressed() -> void:
	Main.new_game = 1
	$Menu.hide()


func _on_Help_pressed() -> void:
	Main.new_game = 0

	$HelpM.show()


func _on_CloseHelpM_pressed() -> void:
	Main.new_game = 1
	$HelpM.hide()
