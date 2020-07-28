extends Node2D

signal ads_done

var screenSize = Vector2(0,0)
var background_scenes = preload("res://Scenes/Background.tscn")

onready var admob = $AdMob
onready var debug_out = $CenterContainer/DebugOut


func _ready() -> void:
	setup()



func setup():
	print("ADs setup()")
	screenSize = get_viewport().get_visible_rect().size
	$CenterContainer/ADImage.rect_min_size = screenSize	
	$CloseADs.visible = true
#	var background_node = background_scenes.instance()
#	self.add_child(background_node)
#	background_node.set_visible(true)
#	Main.show_background_node(false)
	print("set screen size = %s" %  screenSize)
	$TimerTime.visible = false
	ads_set_timer()

func ads_set_timer():
	print("ADs ads_set_timer()")
#	$ADsTimer.wait_time = 3
#	$ADsTimer.one_shot = true

func start_ads_timer():
	print("ADs start_ads_timer()")
	$TimerTime.visible = true
#	$CloseADs.visible = false
#	$ADsTimer.start()

#func _process(delta: float) -> void:
#	if $ADsTimer.get_time_left() != 0:
#		$TimerTime.text = str($ADsTimer.time_left)

func _on_ADsTimer_timeout() -> void:
	print("ADs _on_ADsTimer_timeout()")
	$TimerTime.visible = false
	$CloseADs.visible = true

func _on_Button_pressed() -> void:
	print("ADs _on_Button_pressed()")
	emit_signal("ads_done")
	Main.ads_node.hide()
	Main.new_game()




# buttons callbacks
func _on_BtnBanner_toggled(button_pressed):
		if button_pressed: admob.show_banner()
		else: admob.hide_banner()

func _on_BtnInterstitial_pressed():
	debug_out.text = debug_out.text + "Interstitial loaded before shown = " + str(admob.is_interstitial_loaded()) +"\n"
	admob.show_interstitial()
	debug_out.text = debug_out.text + "Interstitial loaded after shown = " + str(admob.is_interstitial_loaded()) +"\n"

func _on_BtnRewardedVideo_pressed():
	debug_out.text = debug_out.text + "Rewarded loaded before shown = " + str(admob.is_rewarded_video_loaded()) +"\n"
	admob.show_rewarded_video()
	debug_out.text = debug_out.text + "Rewarded loaded after shown = " + str(admob.is_rewarded_video_loaded()) +"\n"

# AdMob callbacks
func _on_resize():
	debug_out.text = debug_out.text + "Banner resized\n"
	admob.banner_resize()

func _on_AdMob_banner_failed_to_load(error_code):
	debug_out.text = debug_out.text + "Banner failed to load: Error code " + str(error_code) + "\n"

func _on_AdMob_banner_loaded():
	$"BtnBanner".disabled = false
	debug_out.text = debug_out.text + "Banner loaded\n"
	debug_out.text = debug_out.text + "Banner size = " + str(admob.get_banner_dimension()) +  "\n"

func _on_AdMob_interstitial_loaded():
	$"BtnInterstitial".disabled = false
	debug_out.text = debug_out.text + "Interstitial loaded\n"

func _on_AdMob_interstitial_closed():
	debug_out.text = debug_out.text + "Interstitial closed\n"
	$"BtnInterstitial".disabled = true

func _on_AdMob_interstitial_failed_to_load(error_code):
	debug_out.text = debug_out.text + "Interstitial failed to load: Error code " + str(error_code) + "\n"

func _on_AdMob_network_error():
	debug_out.text = debug_out.text + "Network error\n"

func _on_AdMob_rewarded(currency, amount):
	debug_out.text = debug_out.text + "Rewarded watched, currency: " + str(currency) + " amount:"+ str(amount)+ "\n"

func _on_AdMob_rewarded_video_closed():
	debug_out.text = debug_out.text + "Rewarded video closed\n"
	$"BtnRewardedVideo".disabled = true
	admob.load_rewarded_video()

func _on_AdMob_rewarded_video_failed_to_load(error_code):
	debug_out.text = debug_out.text + "Rewarded video failed to load: Error code " + str(error_code) + "\n"

func _on_AdMob_rewarded_video_left_application():
	debug_out.text = debug_out.text + "Rewarded video left application\n"

func _on_AdMob_rewarded_video_loaded():
	$"BtnRewardedVideo".disabled = false
	debug_out.text = debug_out.text + "Rewarded video loaded\n"

func _on_AdMob_rewarded_video_opened():
	debug_out.text = debug_out.text + "Rewarded video opened\n"

func _on_AdMob_rewarded_video_started():
	debug_out.text = debug_out.text + "Rewarded video started\n"


