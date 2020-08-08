extends Node2D

signal change_number


# onready var effect = get_node("move_tween")
# onready var destroy = get_node("destroy_tween")
# onready var alpha = get_node("alpha_tween")
# onready var timer = get_node("destroy_timer")
var is_number_exist = false
var number = 0
var mas_coord = 0
var is_2584
var colors = []

var curry_row = 0
var currx_col = 0
var prev_them = Main.is_dark
var text_label = ""

func set_xy(rowy, colx):
	curry_row = rowy
	currx_col = colx
	set_color()
	

func set_number_to_label(num : int):
	text_label = num as String
	#$MarginContainer/CenterContainer/ColorRect/Label.text = str(num)
	$CenterContainer/Label.text = str(num)
	is_number_exist = true
	number = num 
	set_color()

#func _ready():
#	enter_scene()

#func _process(delta):	
#


func number_plate_signal():
	#играть музыку мигать фонариками запускать фейерверки	 
	#print("number_plate_signal")
	Main.show_message("Congratulation! \n You have achieved 2584!")	
	for i in 40:
		$CenterContainer/ColorRect.color = ("ff0000")
		yield(get_tree().create_timer(0.01), "timeout")
		$CenterContainer/ColorRect.color = ("00ff00")
		yield(get_tree().create_timer(0.01), "timeout")
		$CenterContainer/ColorRect.color = ("0000ff")
		yield(get_tree().create_timer(0.01), "timeout")


func do_graz_2584():
#	print("pozdr s 2584")
	if (is_2584 == true) and (Main.numarr.has(number)):
		number_plate_signal()
		is_2584 = false
		Main.reasign_numbers_on_gamefield()
	else:
		return
	


func do_graz_adsoff():
	print("pozdr s 7778742049 no ads for you")
	


func check_gz():
	if Main.numarr.has(number):
		is_2584 == true
	

func set_empty_number():
	is_2584 = false
	check_gz()
	$CenterContainer/Label.text = ''
	is_number_exist = null
	number = null
	set_color()	

func set_number_fonts_size():
	# number
	pass

func set_number_text(text):
	is_2584 = false
	check_gz()
	$CenterContainer/Label.text = text
	is_number_exist = 1
	number = null
	set_color()	
	
func setup_number_rect(size : Vector2):
	#print("Number setup()")
	is_2584 = false
	check_gz()
	$CenterContainer.rect_min_size = (size - Vector2(4,4))
	$CenterContainer/ColorRect.rect_min_size = (size - Vector2(4,4))
	$CenterContainer/Label.rect_min_size = (size - Vector2(4,4))
	set_color()
	#print("set number size = %s" %  size)


# func enter_scene():
# 	effect.interpolate_property(self, "scale", Vector2(.3, .3), Vector2(1, 1), .6, Tween.TRANS_CIRC, Tween.EASE_OUT)
# 	effect.start()

# func move(new_position):
# 	effect.interpolate_property(self, "position", position, new_position, .3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
# 	effect.start()

# func start_timer():
# 	destroy_piece()

# func destroy_piece():
# 	#Use a tween to make the piece larger
# 	destroy.interpolate_property(self, "scale", Vector2(1, 1), Vector2(1.4, 1.4), .6, Tween.TRANS_CUBIC, Tween.EASE_OUT)
# 	destroy.start()
# 	#Use a tween to make the piece disappear
# 	alpha.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), .6, Tween.TRANS_SINE, Tween.EASE_OUT)
# 	alpha.start()

# func _on_destroy_timer_timeout():
# 	destroy_piece()

# func _on_alpha_tween_tween_completed(object, key):
# 	queue_free()

func set_color_mas():
	colors = [
	"gray = Color( 0.75, 0.75, 0.75, 1 )",
	"aliceblue = Color( 0.94, 0.97, 1, 1 )",
	"antiquewhite = Color( 0.98, 0.92, 0.84, 1 )",
	"aqua = Color( 0, 1, 1, 1 )",
	"aquamarine = Color( 0.5, 1, 0.83, 1 )",
	"azure = Color( 0.94, 1, 1, 1 )",
	"beige = Color( 0.96, 0.96, 0.86, 1 )",
	"bisque = Color( 1, 0.89, 0.77, 1 )",
	"black = Color( 0, 0, 0, 1 )",
	"blanchedalmond = Color( 1, 0.92, 0.8, 1 )",
	"blue = Color( 0, 0, 1, 1 )",
	"blueviolet = Color( 0.54, 0.17, 0.89, 1 )",
	"brown = Color( 0.65, 0.16, 0.16, 1 )",
	"burlywood = Color( 0.87, 0.72, 0.53, 1 )",
	"cadetblue = Color( 0.37, 0.62, 0.63, 1 )",
	"chartreuse = Color( 0.5, 1, 0, 1 )",
	"chocolate = Color( 0.82, 0.41, 0.12, 1 )",
	"coral = Color( 1, 0.5, 0.31, 1 )",
	"cornflower = Color( 0.39, 0.58, 0.93, 1 )",
	"cornsilk = Color( 1, 0.97, 0.86, 1 )",
	"crimson = Color( 0.86, 0.08, 0.24, 1 )",
	"cyan = Color( 0, 1, 1, 1 )",
	"darkblue = Color( 0, 0, 0.55, 1 )",
	"darkcyan = Color( 0, 0.55, 0.55, 1 )",
	"darkgoldenrod = Color( 0.72, 0.53, 0.04, 1 )",
	"darkgray = Color( 0.66, 0.66, 0.66, 1 )",
	"darkgreen = Color( 0, 0.39, 0, 1 )",
	"darkkhaki = Color( 0.74, 0.72, 0.42, 1 )",
	"darkmagenta = Color( 0.55, 0, 0.55, 1 )",
	"darkolivegreen = Color( 0.33, 0.42, 0.18, 1 )",
	"darkorange = Color( 1, 0.55, 0, 1 )",
	"darkorchid = Color( 0.6, 0.2, 0.8, 1 )",
	"darkred = Color( 0.55, 0, 0, 1 )",
	"darksalmon = Color( 0.91, 0.59, 0.48, 1 )",
	"darkseagreen = Color( 0.56, 0.74, 0.56, 1 )",
	"darkslateblue = Color( 0.28, 0.24, 0.55, 1 )",
	"darkslategray = Color( 0.18, 0.31, 0.31, 1 )",
	"darkturquoise = Color( 0, 0.81, 0.82, 1 )",
	"darkviolet = Color( 0.58, 0, 0.83, 1 )",
	"deeppink = Color( 1, 0.08, 0.58, 1 )",
	"deepskyblue = Color( 0, 0.75, 1, 1 )",
	"dimgray = Color( 0.41, 0.41, 0.41, 1 )",
	"dodgerblue = Color( 0.12, 0.56, 1, 1 )",
	"firebrick = Color( 0.7, 0.13, 0.13, 1 )",
	"floralwhite = Color( 1, 0.98, 0.94, 1 )",
	"forestgreen = Color( 0.13, 0.55, 0.13, 1 )",
	"fuchsia = Color( 1, 0, 1, 1 )",
	"gainsboro = Color( 0.86, 0.86, 0.86, 1 )",
	"ghostwhite = Color( 0.97, 0.97, 1, 1 )",
	"gold = Color( 1, 0.84, 0, 1 )",
	"goldenrod = Color( 0.85, 0.65, 0.13, 1 )",
	"green = Color( 0, 1, 0, 1 )",
	"greenyellow = Color( 0.68, 1, 0.18, 1 )",
	"honeydew = Color( 0.94, 1, 0.94, 1 )",
	"hotpink = Color( 1, 0.41, 0.71, 1 )",
	"indianred = Color( 0.8, 0.36, 0.36, 1 )",
	"indigo = Color( 0.29, 0, 0.51, 1 )",
	"ivory = Color( 1, 1, 0.94, 1 )",
	"khaki = Color( 0.94, 0.9, 0.55, 1 )",
	"lavender = Color( 0.9, 0.9, 0.98, 1 )",
	"lavenderblush = Color( 1, 0.94, 0.96, 1 )",
	"lawngreen = Color( 0.49, 0.99, 0, 1 )",
	"lemonchiffon = Color( 1, 0.98, 0.8, 1 )",
	"lightblue = Color( 0.68, 0.85, 0.9, 1 )",
	"lightcoral = Color( 0.94, 0.5, 0.5, 1 )",
	"lightcyan = Color( 0.88, 1, 1, 1 )",
	"lightgoldenrod = Color( 0.98, 0.98, 0.82, 1 )",
	"lightgray = Color( 0.83, 0.83, 0.83, 1 )",
	"lightgreen = Color( 0.56, 0.93, 0.56, 1 )",
	"lightpink = Color( 1, 0.71, 0.76, 1 )",
	"lightsalmon = Color( 1, 0.63, 0.48, 1 )",
	"lightseagreen = Color( 0.13, 0.7, 0.67, 1 )",
	"lightskyblue = Color( 0.53, 0.81, 0.98, 1 )",
	"lightslategray = Color( 0.47, 0.53, 0.6, 1 )",
	"lightsteelblue = Color( 0.69, 0.77, 0.87, 1 )",
	"lightyellow = Color( 1, 1, 0.88, 1 )",
	"lime = Color( 0, 1, 0, 1 )",
	"limegreen = Color( 0.2, 0.8, 0.2, 1 )",
	"linen = Color( 0.98, 0.94, 0.9, 1 )",
	"magenta = Color( 1, 0, 1, 1 )",
	"maroon = Color( 0.69, 0.19, 0.38, 1 )",
	"mediumaquamarine = Color( 0.4, 0.8, 0.67, 1 )",
	"mediumblue = Color( 0, 0, 0.8, 1 )",
	"mediumorchid = Color( 0.73, 0.33, 0.83, 1 )",
	"mediumpurple = Color( 0.58, 0.44, 0.86, 1 )",
	"mediumseagreen = Color( 0.24, 0.7, 0.44, 1 )",
	"mediumslateblue = Color( 0.48, 0.41, 0.93, 1 )",
	"mediumspringgreen = Color( 0, 0.98, 0.6, 1 )",
	"mediumturquoise = Color( 0.28, 0.82, 0.8, 1 )",
	"mediumvioletred = Color( 0.78, 0.08, 0.52, 1 )",
	"midnightblue = Color( 0.1, 0.1, 0.44, 1 )",
	"mintcream = Color( 0.96, 1, 0.98, 1 )",
	"mistyrose = Color( 1, 0.89, 0.88, 1 )",
	"moccasin = Color( 1, 0.89, 0.71, 1 )",
	"navajowhite = Color( 1, 0.87, 0.68, 1 )",
	"navyblue = Color( 0, 0, 0.5, 1 )",
	"oldlace = Color( 0.99, 0.96, 0.9, 1 )",
	"olive = Color( 0.5, 0.5, 0, 1 )",
	"olivedrab = Color( 0.42, 0.56, 0.14, 1 )",
	"orange = Color( 1, 0.65, 0, 1 )",
	"orangered = Color( 1, 0.27, 0, 1 )",
	"orchid = Color( 0.85, 0.44, 0.84, 1 )",
	"palegoldenrod = Color( 0.93, 0.91, 0.67, 1 )",
	"palegreen = Color( 0.6, 0.98, 0.6, 1 )",
	"paleturquoise = Color( 0.69, 0.93, 0.93, 1 )",
	"palevioletred = Color( 0.86, 0.44, 0.58, 1 )",
	"papayawhip = Color( 1, 0.94, 0.84, 1 )",
	"peachpuff = Color( 1, 0.85, 0.73, 1 )",
	"peru = Color( 0.8, 0.52, 0.25, 1 )",
	"pink = Color( 1, 0.75, 0.8, 1 )",
	"plum = Color( 0.87, 0.63, 0.87, 1 )",
	"powderblue = Color( 0.69, 0.88, 0.9, 1 )",
	"purple = Color( 0.63, 0.13, 0.94, 1 )",
	"rebeccapurple = Color( 0.4, 0.2, 0.6, 1 )",
	"red = Color( 1, 0, 0, 1 )",
	"rosybrown = Color( 0.74, 0.56, 0.56, 1 )",
	"royalblue = Color( 0.25, 0.41, 0.88, 1 )",
	"saddlebrown = Color( 0.55, 0.27, 0.07, 1 )",
	"salmon = Color( 0.98, 0.5, 0.45, 1 )",
	"sandybrown = Color( 0.96, 0.64, 0.38, 1 )",
	"seagreen = Color( 0.18, 0.55, 0.34, 1 )",
	"seashell = Color( 1, 0.96, 0.93, 1 )",
	"sienna = Color( 0.63, 0.32, 0.18, 1 )",
	"silver = Color( 0.75, 0.75, 0.75, 1 )",
	"skyblue = Color( 0.53, 0.81, 0.92, 1 )",
	"slateblue = Color( 0.42, 0.35, 0.8, 1 )",
	"slategray = Color( 0.44, 0.5, 0.56, 1 )",
	"snow = Color( 1, 0.98, 0.98, 1 )",
	"springgreen = Color( 0, 1, 0.5, 1 )",
	"steelblue = Color( 0.27, 0.51, 0.71, 1 )",
	"tan = Color( 0.82, 0.71, 0.55, 1 )",
	"teal = Color( 0, 0.5, 0.5, 1 )",
	"thistle = Color( 0.85, 0.75, 0.85, 1 )",
	"tomato = Color( 1, 0.39, 0.28, 1 )",
	"turquoise = Color( 0.25, 0.88, 0.82, 1 )",
	"violet = Color( 0.93, 0.51, 0.93, 1 )",
	"webgray = Color( 0.5, 0.5, 0.5, 1 )",
	"webgreen = Color( 0, 0.5, 0, 1 )",
	"webmaroon = Color( 0.5, 0, 0, 1 )",
	"webpurple = Color( 0.5, 0, 0.5, 1 )",
	"wheat = Color( 0.96, 0.87, 0.7, 1 )",
	"white = Color( 1, 1, 1, 1 )",
	"whitesmoke = Color( 0.96, 0.96, 0.96, 1 )",
	"yellow = Color( 1, 1, 0, 1 )",
	"yellowgreen = Color( 0.6, 0.8, 0.2, 1 )",
	]


func select_node_to_color(color : Color):
	$CenterContainer/ColorRect.color = color

func select_node_to_color_hsv(color : Color):
	$CenterContainer/ColorRect.color.from_hsv(color)




func set_color_dyn():
	# три цвета
	# контрастность
	# насыщенность
	pass

func set_color():
	if Main.is_dark == true:
		set_color_darker()
	else:
		set_color_bright()


func set_color_darker():
	#print("set_color() number =", number)
	#0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711
#	var currnumber = Main.fibn(number) 
#	var nextnumber
#	var prevnumber
#	if Main.fibn(number) 
	
	if number == null:				
		select_node_to_color(Color( 0.3, 0.3, 0.3, 0.3 ))
	elif number == 2 :
		select_node_to_color("7ca66d")
	elif number == 4 :
		select_node_to_color("68a08b")
	elif number == 8 :
		select_node_to_color("5d8686")
	elif number == 16 :
		select_node_to_color("506c80")
	elif number == 32 :
		select_node_to_color("585c88")
	elif number == 64 :
		select_node_to_color("695887")
	elif number == 128 :
		select_node_to_color("6e4e7b")
	elif number == 256:
		select_node_to_color("764873")
	elif number == 512 :
		select_node_to_color("ca5973")
	elif number == 1024 :
		select_node_to_color("f96d42")
	elif number == 2048 :
		do_graz_2584()
		select_node_to_color("e5a03e")
	elif number == 4096:
		select_node_to_color("f0ed0f")	
	elif number == 8192 :
		select_node_to_color("acee0b")	
	elif number == 16384 :
		select_node_to_color("0ce32d")	
	elif number == 32768:
		select_node_to_color("08f7e1")	
	elif number == -256 :
		select_node_to_color("b105ef")
	elif number ==  -512 :
		select_node_to_color("9403cf")
	elif number == -1024 :
		select_node_to_color("d6048a")
	elif number == -2048 :
		select_node_to_color("d6056c")	
	else:
		select_node_to_color("d62147")


func set_color_bright():
	#print("set_color() number =", number)
	#0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711
	if number == null:				
		select_node_to_color(Color( 0.3, 0.3, 0.3, 0.3 ))
	elif number == 2 :
		select_node_to_color("5799a7")
	elif number == 4 :
		select_node_to_color("a49d4a")
	elif number == 8 :
		select_node_to_color("71cf17")
	elif number == 16 :
		select_node_to_color("17cfad")
	elif number == 32 :
		select_node_to_color("1741cf")
	elif number == 64 :
		select_node_to_color("a517cf")
	elif number == 128 :
		select_node_to_color("cf8917")
	elif number == 256 :
		select_node_to_color("17cf79")
	elif number == 512 :
		select_node_to_color("1763cf")
	elif number == 1024 :
		select_node_to_color("7317cf")
	elif number == 2048 :
		do_graz_2584()
		select_node_to_color("cf1796")
	elif number == 4096 :
		select_node_to_color("cf173c")	
	elif number == 8192 :
		select_node_to_color("ec4a0b")	
	elif number == 16384 :
		select_node_to_color("20ff00")				
	elif number == 32768 :
		select_node_to_color("ff2929")		
	elif number == -256 :
		select_node_to_color("29fff5")
	elif number == -512 :
		select_node_to_color("2959ff")
	elif number == -1024 :
		select_node_to_color("9429ff")
	elif number == -2048 :
		select_node_to_color("ff29e3")
	else:
		select_node_to_color("004cff")
	
