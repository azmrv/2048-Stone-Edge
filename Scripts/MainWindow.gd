extends Node2D


var screenSize = Vector2(0,0)

var game_window_width_x = 0
var game_window_heigth_y = 0

var first_touch = Vector2(0, 0)
var final_touch = Vector2(0, 0)
var swipe_start = null
var minimum_drag = 100
var swipe = null

onready var admob = $AdMob
#onready var debug_out = null #$CanvasLayer/DebugOut

func _ready() -> void:
	setup()
	Main.new_game()
#	admob.load_banner()
#	admob.load_interstitial()
#	admob.load_rewarded_video()
## warning-ignore:return_value_discarded
#	get_tree().connect("screen_resized", self, "_on_resize")


func setup():
	print("MainWindow setup()")
#	screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
#	screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
#	$MainWindow.rect_min_size = screenSize
#	game_field_size = Main.game_field_size
	game_window_width_x = screenSize.x
	game_window_heigth_y = screenSize.y
#	game_field_width_x = game_window_width_x
	print("set screen size = %s" %  screenSize)



func _input(event):
	Main.undo_game_field = Main.game_field
	if (Main.new_game != 0) && (Main.clickInput == true):
		#print("_input(event)", event)
		if(Input.is_action_just_pressed("ui_touch")):
			print("_input(event) - (Input.is_action_just_PREssed(ui_touch))")
			first_touch = (get_global_mouse_position())
		if(Input.is_action_just_released("ui_touch")):
			print("_input(event) - (Input.is_action_just_REleased(ui_touch))")
			final_touch = (get_global_mouse_position())
			calculate_direction()
	elif (Main.new_game != 0) && (Main.clickInput == false):
		if event is InputEventScreenTouch:
			if event.pressed:
			  swipe_start = event.get_position()
			else:
			  _calculate_swipe(event.get_position())

#func _unhandled_input(event):
#	if (Main.new_game != 0) && (Main.clickInput == false):
#		if event is InputEventScreenTouch:
#			if event.pressed:
#			  swipe_start = event.get_position()
#			else:
#			  _calculate_swipe(event.get_position())

func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			Main.move_right(Main.game_field)
		if swipe.x < 0:
			Main.move_left(Main.game_field)
	if abs(swipe.y) > minimum_drag:
		if swipe.y > 0:
			Main.move_down(Main.game_field)
		if swipe.y < 0:
			Main.move_up(Main.game_field)

func calculate_direction():
	var k_scr = (game_window_heigth_y - game_window_width_x)/2
#	print("calculate_direction()")
#	print("y =", final_touch.y, " x =", final_touch.x)	
	if final_touch.x > final_touch.y-k_scr:		
		if final_touch.x + final_touch.y-k_scr < game_window_width_x:
			Main.move_up(Main.game_field)
		else:
			Main.move_right(Main.game_field)
	else:
		if final_touch.x + final_touch.y-k_scr < game_window_width_x:
			Main.move_left(Main.game_field)
		else:
			Main.move_down(Main.game_field) 



