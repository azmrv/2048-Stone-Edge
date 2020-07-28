extends Control

signal gui_mm_start_new_game
signal gui_mm_options
signal gui_mm_help

var screenSize = Vector2(0,0)


func _ready() -> void:
	setup()
	setup_signals()
	
func setup_signals():
	print("setup_signals()")
	#$VBoxContainer/CentContButtons/VBoxButtons/StartGame.connect("gui_mm_start_new_game", self, "_on_StartGame_pressed")


func setup_scenes():
	pass



func setup():
	print("GUI_MainMenu setup()")
	screenSize = get_viewport().get_visible_rect().size
	self.rect_min_size = screenSize
	print("set screen size = %s" %  screenSize)

	

func _on_ExitGame_pressed() -> void:
	get_tree().quit()


func _on_StartGame_pressed() -> void:
	print("_on_StartGame_pressed() -> emit_signal(gui_mm_start_new_game)")
	emit_signal("gui_mm_start_new_game")


func _on_Options_pressed() -> void:
	print("_on_Options_pressed() -> emit_signal(gui_mm_options)")
	emit_signal("gui_mm_options")


func _on_Help_pressed() -> void:
	print("_on_Help_pressed() -> emit_signal(gui_mm_help)")
	emit_signal("gui_mm_help")
