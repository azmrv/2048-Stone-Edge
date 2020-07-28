extends Node

#This node exists solely to collect and send signals to othr parts of the application
#So any signal needing to be retrieved can simply come here to get the data.
#My first ever manager.  The "Signal Manager"
#Note this IS a singleton.  Not sure if I should have my hand slapped or not?
signal scoreAdjusted(adjustedScore)         #score/money in top right corner
signal menuSlide                            #toggle sliding of main menu
signal pauseGameToggle                      #pause and unpause game
signal modalVisibilityToggle(whichDialog)   #can triger a modal to fade out with its animplayer "fadeOut" and "fadeIn" animations using this
signal newGame
signal gameOver
signal showAds

func _ready():
	pass

