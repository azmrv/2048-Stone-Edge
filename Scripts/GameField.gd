extends Node2D


#onready var effect = get_node("move_tween")
#onready var destroy = get_node("destroy_tween")
#onready var alpha = get_node("alpha_tween")
#onready var timer = get_node("destroy_timer")


var screenSize = Vector2(0,0)



func _ready() -> void:
	setup()
	


func setup():
	#print("GameField setup()")
	#screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
	#screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	#screenSize = get_viewport().get_visible_rect().size
	#$VBoxContainer.rect_min_size = screenSize
	#$VBoxContainer/ColorRect.rect_min_size.x = screenSize.x
	#$VBoxContainer/ColorRect.rect_min_size.y = screenSize.x
	#print("set screen size = %s" %  screenSize)
	pass



func enter_scene():
#	effect.interpolate_property(self, "scale", Vector2(.3, .3), Vector2(1, 1), .6, Tween.TRANS_CIRC, Tween.EASE_OUT)
#	effect.start()
	pass

func move(new_position):
#	effect.interpolate_property(self, "position", position, new_position, .3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
#	effect.start()
	pass

func start_timer():
#	destroy_number()
	pass

func destroy_number():
#	#Use a tween to make the piece larger
#	destroy.interpolate_property(self, "scale", Vector2(1, 1), Vector2(1.4, 1.4), .6, Tween.TRANS_CUBIC, Tween.EASE_OUT)
#	destroy.start()
#	#Use a tween to make the piece disappear
#	alpha.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), .6, Tween.TRANS_SINE, Tween.EASE_OUT)
#	alpha.start()
	pass

func _on_destroy_timer_timeout():
	destroy_number()


func _on_alpha_tween_tween_completed(_object, _key):
	queue_free()



#func _ready():
#	setup()

func setup_field():
#	for i in width:
#		for j in height:
#			var bkg = tile_background.instance()
#			add_child(bkg)
#			bkg.position = Vector2(x_start + i * 128, y_start + j * -128)
	pass
	
#func _process(_delta):
#	#draw_numbers()
#	pass


func draw_numbers():
	
	pass
