extends Node2D

# export (PackedScene) var Background
# var game_field_size = 6
# var width = game_field_size
# var height = game_field_size
# var x_start = 96
# var y_start = 704

var screenSize = Vector2(0,0)



func _ready() -> void:
	setup()


func setup():
	print("Background setup()")
#	screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
#	screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
	$CenterContainer/ColorRect.rect_min_size = screenSize
	print("set screen size = %s" %  screenSize)


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
