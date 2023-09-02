extends Control

var decisionAlreadySeen: Array
var worldData: WorldData

#NoTouch -------------------------------------------------------------- # Decisions
const filePath = "res://Scenes/Decisions/decisionsData.tres"
var decisionsDict = {}
func _ready():
	if FileAccess.file_exists(filePath):
		var loaded = load(filePath)
		decisionsDict = loaded.decisionsDict
		worldData = WorldData.load_or_create(Globals.currentWorld)
	else:
		#load from web -- WIP
		print("Your Decisions file is mising")
#NoTouch -------------------------------------------------------------- # Decisions
####################
var chosenDecision: int
#Decisions Data
var keywords: Array
var storydecision: String
var dec1: String
var dec2: String
var consequence1: Dictionary
var consequence2: Dictionary
func decisionsDictLoaded():
	keywords = decisionsDict[chosenDecision]["KEYWORDS"]
	storydecision = decisionsDict[chosenDecision]["STORYDECISION"]
	dec1 = decisionsDict[chosenDecision]["DEC1"]
	dec2 = decisionsDict[chosenDecision]["DEC2"]
	consequence1 = decisionsDict[chosenDecision]["CONSEQUENCE1"]
	consequence2 = decisionsDict[chosenDecision]["CONSEQUENCE2"]
var rng = RandomNumberGenerator.new()
func DecisionsLogic():
	WorldData.load_or_create(Globals.currentWorld)
	decisionAlreadySeen = worldData.decisionAlreadySeen
	chosenDecision = rng.randi_range(1, decisionsDict.size())
	if not decisionsDict.size() == decisionAlreadySeen.size():
		if not chosenDecision in decisionAlreadySeen:  #if the random num isnt in the array, it saves it and makes a world
			decisionAlreadySeen.append(chosenDecision) #adds it to the array
			worldData.decisionAlreadySeen = decisionAlreadySeen #saves it to the speciufc world singleton
			decisionsDictLoaded() #calls
			START_INTERACTION()
		else:
			DecisionsLogic() #trys again
	else:
		print("you have gone trough all the decisions")
func _on_questionmark_button_pressed():
	DecisionsLogic()

#NoTouch --------------------------------------------------------------
#NoTouch --------------------------------------------------------------
#NoTouch --------------------------------------------------------------
@onready var animationPlayer = $FullAnimations
@onready var mainText: RichTextLabel = $CanvasLayer/SizeControll/mainText/RichTextLabel
@onready var options = $CanvasLayer/SizeControll/Options
@onready var option1: Label = $CanvasLayer/SizeControll/Options/HBoxContainer/option1/option1Label
@onready var option2: Label = $CanvasLayer/SizeControll/Options/HBoxContainer/option2/option2Label
@onready var option1Button: Button = $CanvasLayer/SizeControll/Options/HBoxContainer/option1
@onready var option2Button: Button = $CanvasLayer/SizeControll/Options/HBoxContainer/option2
func START_INTERACTION():
	$CanvasLayer.visible = true
	storyfunc() #calls
func storyfunc():    #add voice here
	keywordsfunc()
	mainText.text = storydecision
	start_dialogue()
func keywordsfunc() -> void:
	$StartEndAnimations.play("default")
	for i in keywords:
		animationPlayer.play(i)
func decisionfunc():
	options.visible = true
	option1.text = dec1
	option2.text = dec2
func _on_option_1_pressed() -> void:
	consequenceResoult(consequence1)
	option1Button.disabled = true
	option2Button.disabled = true
func _on_option_2_pressed() -> void:
	consequenceResoult(consequence2)
	option1Button.disabled = true
	option2Button.disabled = true

var itsEnding = false
#IMPORTANT VARS! ------------------- IMPORTANT VARS! ------------------- IMPORTANT VARS!
var decisionAddedArray: Array

var playerReputationMulitplayer: float = 1.1
var playerCashMulitplayer: float = 1.1
var playerConnectionsMulitplayer: float = 1.1
var playerGoldMulitplayer: float = 1.1
var playerFitnessMulitplayer: float = 1.1
var playerHealthMulitplayer: float = 1.1
var playerKnowledgeMulitplayer: float = 1.1


func consequenceResoult(consequence: Dictionary) -> void:
	
	if consequence.has("time"):
		if consequence["time"]:
			mainText.text = consequence["consequenceText"]
			itsEnding = true
			start_dialogue()
		else:
			mainText.text = consequence["consequenceText"]
			itsEnding = true
			start_dialogue()

	if consequence.has("reputation"):
		if consequence["reputation"]:
			var theReputationAmmount = snapped((randf_range(0.1, 0.5) * playerReputationMulitplayer), 0.01)
			decisionAddedArray.append(str("Reputation : +", theReputationAmmount))
			worldData.playerReputation += theReputationAmmount
		else:
			worldData.playerReputation -= 0.1

	if consequence.has("playercash"):
		if consequence["playercash"]:
			var theCashAmmount = snapped((randf_range(1, 15) * playerCashMulitplayer), 0.01)
			decisionAddedArray.append(str("Cash: +", theCashAmmount, "$"))
			worldData.playerCash += theCashAmmount
		else:
			worldData.playerCash -= 0.1

	if consequence.has("socialconnections"):
		if consequence["socialconnections"]:
			var theConnectionsAmmount = snapped((randf_range(0.1, 0.5) * playerConnectionsMulitplayer), 0.01)
			decisionAddedArray.append(str("Connections : +", theConnectionsAmmount))
			worldData.socialconnections += theConnectionsAmmount
		else:
			worldData.socialconnections -= 0.1

	if consequence.has("playergold"):
		if consequence["playergold"]:
			var theGoldAmmount = snapped((randf_range(0.1, 0.5) * playerGoldMulitplayer), 0.01)
			decisionAddedArray.append(str("Gold : +", theGoldAmmount, "g"))
			worldData.playerGold += theGoldAmmount
		else:
			worldData.playerGold -= 0.1

	if consequence.has("fitnesslevel"):
		if consequence["fitnesslevel"]:
			var theFitnessAmmount = snapped((randf_range(0.1, 0.5) * playerFitnessMulitplayer), 0.01)
			decisionAddedArray.append(str("Fitness : +", theFitnessAmmount))
			worldData.fitnesslevel += theFitnessAmmount
		else:
			worldData.fitnesslevel -= 0.1

	if consequence.has("health"):
		if consequence["health"]:
			var theHealthAmmount = snapped((randf_range(0.1, 0.5) * playerHealthMulitplayer), 0.01)
			decisionAddedArray.append(str("Health : +", theHealthAmmount))
			worldData.health += theHealthAmmount
		else:
			worldData.health -= 0.1

	if consequence.has("knowledge"):
		if consequence["knowledge"]:
			var theKnowledgeAmmount = snapped((randf_range(0.1, 0.5) * playerKnowledgeMulitplayer), 0.01)
			decisionAddedArray.append(str("Knowledge : +", theKnowledgeAmmount))
			worldData.knowledge += theKnowledgeAmmount
		else:
			worldData.knowledge -= 0.1
			
	worldData.save(Globals.currentWorld)

func GlobalsHasChanged():
	$OutcomesCanvasLayer/OutComes/VBoxContainer/labelONE.text = str(decisionAddedArray[0])
	if decisionAddedArray.size() >= 2:
		$OutcomesCanvasLayer/OutComes/VBoxContainer/labelTWO.text = str(decisionAddedArray[1])
	if decisionAddedArray.size() >= 3:
		$OutcomesCanvasLayer/OutComes/VBoxContainer/labelTHREE.text = str(decisionAddedArray[2])
	
	decisionAddedArray = []

# Ignore ------------- Ignore ------------- Ignore ------------- Ignore

func endInteraction() -> void:
	options.visible = false
	$StartEndAnimations.play_backwards("default")
	for i in keywords:
		animationPlayer.play(i + "b")
	mainText.text = ""
	option1Button.disabled = false
	option2Button.disabled = false
	$CanvasLayer.visible = false
	$OutcomesCanvasLayer.visible = true
	GlobalsHasChanged()
	await get_tree().create_timer(2).timeout
	$OutcomesCanvasLayer.visible = false
	#interactio nended
func start_dialogue() -> void:
	mainText.visible_ratio = 0
	while mainText.visible_ratio < 1:
		await get_tree().create_timer(0.05).timeout
		mainText.visible_characters += 1
	await get_tree().create_timer(1).timeout
	decisionfunc()
	if itsEnding:
		await get_tree().create_timer(2).timeout
		endInteraction()
		itsEnding = false

#DECISIONS ------------------------- OUTCOME -------------------------- LOGIC
#DECISIONS ------------------------- OUTCOME -------------------------- LOGIC
#DECISIONS ------------------------- OUTCOME -------------------------- LOGIC
