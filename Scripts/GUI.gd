extends Node2D

signal gui_start_new_game
signal gui_exit_to_menu
signal gui_help
signal gui_options
signal gui_psyontech
signal gui_undo

var background_scenes = preload("res://Scenes/Background.tscn")

var game_name = "2048 Stone Edge"

var screenSize = Vector2(0,0)
var showMenuLag = null

var game_field

func _ready() -> void:
	print("GUI ready()")	
	setup()
	setup_signals()
	setup_nodes()

	

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
	$VBoxC/TelosAds/GameName.text = game_name
#	create_numbers_on_game_field()
	print("set screen size = %s" %  screenSize)



func update_score():
#	print("GUI update_score(score)")
	$VBoxC/Menu/VBox/Score/Score.text = "Score: %s" % str(Main.current_score)
	$VBoxC/Menu/VBox/Score/Best.text = "Best: %s" % str(Main.best_score)    


func setup_signals():
#	print("setup_signals()")
	pass


func show_gameover():
	$VBoxC/Menu/VBox/Buttons.visible = false
	$MessPU.show()
	$MessPU/CRect2/CC/MessageBox.text = "Game over"
	$GameOverT.wait_time = 2
	$GameOverT.start()

func show_message(text):	
	$MessGL.show()
	$MessGL/CC/MessageBox.text = text
	$Timer.wait_time = 2
	# add func to emit colors signal on stone
	$Timer.start()


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
		show_message("Dark Theme activated")
		Main.is_dark = true	
		print("Mode %s" % Main.clickInput)
	if Main.is_dark == true && $Menu/CRect/CenterContainer/VBox/ToggleTheme.pressed == true:
		$Menu/CRect/CenterContainer/VBox/ToggleTheme.pressed = true
		$Menu/CRect/CenterContainer/VBox/ToggleTheme.text = "Bright"
		show_message("Bright Theme activated")
		Main.is_dark = false
		print("Mode %s" % Main.clickInput)
	$Menu.hide()

func _on_ClickMode_pressed() -> void:
	print("GUI Change click mode")	
	if Main.clickInput == true && $Menu/CRect/CenterContainer/VBox/ClickMode.pressed == false:
		$Menu/CRect/CenterContainer/VBox/ClickMode.text = "Click Mode OFF"
		show_message("Click Mode OFF")
		Main.clickInput = false		
		print("Mode %s" % Main.clickInput)
	elif Main.clickInput == false && $Menu/CRect/CenterContainer/VBox/ClickMode.pressed == true:
		$Menu/CRect/CenterContainer/VBox/ClickMode.text = "Click Mode ON"
		show_message("Click Mode ON")
		Main.clickInput = true
		print("Mode %s" % Main.clickInput)
	$Menu.hide()

func _on_Options_pressed() -> void:
	Main.new_game = 1
	$Menu.hide()

func gameover():
	$Menu.hide()
	$Menu.visible = false	
	$HelpM.hide()
	$MessPU.hide()	
	Main.new_game = 1
	Main.game_over()

func _on_AI_pressed() -> void:
	Main.new_game = 1
	$Menu/CRect/CenterContainer/VBox/AI.text = "10 turns AI"
	$Menu.hide()
	AdsManager.showRewardedVideo()
	Main.ai_turns(10)
	


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
	
func _on_GameOverT_timeout() -> void:
	$MessPU.hide()
	$VBoxC/Menu/VBox/Buttons.visible = true
	Main.show_result()


func _on_Timer_timeout() -> void:
	$MessGL.hide()


func _on_GameMode_pressed() -> void:
	if Main.is_classic_2048 == true && $Menu/CRect/CenterContainer/VBox/GameMode.pressed == false:
		$Menu/CRect/CenterContainer/VBox/GameMode.pressed = false
		$Menu/CRect/CenterContainer/VBox/GameMode.text = "To Classic 2048"
		$VBoxC/TelosAds/GameName.modulate = Color.antiquewhite
		game_name = "2048 Stone Edge"
		show_message("Now playing Stone Edge version")
		Main.is_classic_2048 = false
		Main.new_game()		
	if Main.is_classic_2048 == false && $Menu/CRect/CenterContainer/VBox/GameMode.pressed == true:
		$Menu/CRect/CenterContainer/VBox/GameMode.pressed = true
		$Menu/CRect/CenterContainer/VBox/GameMode.text = "To 2048 Stone Edge"
		$VBoxC/TelosAds/GameName.modulate = Color.gold
		game_name = "Classic 2048"
		show_message("Now playing Classic 2048 version")
		Main.is_classic_2048 = true
		Main.new_game()
		AdsManager.showBanner()			
	$Menu.hide()
	$VBoxC/TelosAds/GameName.text = game_name
