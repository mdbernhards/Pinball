extends Node2D

var Score = 0
var OriginalWaitTime

var Points = {
	"RedBall": { "Points": 30, "Count": 0, },
	"RainbowBall": { "Points": 10, "Count": 0, },
	"YellowBox": { "Points": 20, "Count": 0, },
	"GreenPad": { "Points": 50, "Count": 0, },
	"Portal": { "Points": 40, "Count": 0, },
	"BumperPath": { "Points": 20, "Count": 0, },
	"RedBallCombo": { "Points": 2, "Count": 0, },
	"RainbowBallCombo": { "Points": 3, "Count": 0, },
}

var OriginialComboLabelPositionY
var OriginalComboSumLabelPosition

var OriginalPoints = Points.duplicate(true)

func _ready():
	OriginalWaitTime = $ComboLabel/Timer.wait_time
	OriginialComboLabelPositionY = $ComboLabel.position.y
	OriginalComboSumLabelPosition = $ComboSumLabel.position
	
func _process(delta):
	$ComboLabel/Timer/Label.text = "ComboTime: " + str($ComboLabel/Timer.wait_time) + " TimeLeft: " + str($ComboLabel/Timer.time_left)
	ComboLabelBrakingAnimation(delta)
	ComboSumLabelBrakingAnimation(delta)

func ComboLabelBrakingAnimation(delta):
	$ComboLabel.set_position(Vector2($ComboLabel.position.x, $ComboLabel.position.y + 0.2))
	$ComboLabel.scale.y = $ComboLabel.scale.y * 0.9995
	$ComboLabel.scale.x = $ComboLabel.scale.x * 0.9997
	$ComboLabel.modulate.a -= 0.2 * delta
	
func ComboSumLabelBrakingAnimation(delta):
	$ComboSumLabel.set_position(Vector2($ComboSumLabel.position.x -0.1, $ComboSumLabel.position.y + 0.1))
	$ComboSumLabel.scale.y = $ComboSumLabel.scale.y * 0.999
	$ComboSumLabel.scale.x = $ComboSumLabel.scale.x * 0.9993
	$ComboSumLabel.modulate.a -= 0.3 * delta
	
func CalculateScore(score):
	Score += score

func CalculateComboScore():
	var countMultiplier = 0
	var score = 0
	
	for object in Points:
		if (object == "RedBallCombo" or object == "RainbowBallCombo") and Points[object]["Count"] > 0:
			countMultiplier += 1
			score = score * Points[object]["Points"] * Points[object]["Count"]
		elif Points[object]["Count"] > 0:
			score = score + (Points[object]["Points"] * Points[object]["Count"])
			countMultiplier += 1
	
	if countMultiplier:
		score = score * countMultiplier
	
	return score
	
func AddToCombo(type):
	if $ComboLabel/Timer.is_stopped():
		$ComboLabel/Timer.start(OriginalWaitTime)
	else:
		$ComboLabel/Timer.start(clamp($ComboLabel/Timer.wait_time + 0.05, 0, OriginalWaitTime + 3))
	
	Points[type]["Count"] += 1
	SetComboLabel()
	ResetComboText()

func ResetComboText():
	$ComboLabel.scale.y = 1
	$ComboLabel.scale.x = 1
	$ComboLabel.modulate.a = 1
	$ComboLabel.set_position(Vector2($ComboLabel.position.x, OriginialComboLabelPositionY))
	
func SetComboLabel():
	var countMultiplier = 0
	var comboText
	
	for object in Points:
		if (object == "RedBallCombo" or object == "RainbowBallCombo") and Points[object]["Count"] > 0:
			countMultiplier += 1
			if comboText:
				comboText = comboText + "X \n" + str(Points[object]["Points"] * Points[object]["Count"]) + "\n"
		elif Points[object]["Count"] > 0:
			countMultiplier += 1
			if comboText:
				comboText = comboText + "+ \n" + str(Points[object]["Points"]) + "x" + str(Points[object]["Count"]) + "\n"
			else:
				comboText = str(Points[object]["Points"]) + "x" + str(Points[object]["Count"]) + "\n"
			
	if countMultiplier:
		if comboText:
			comboText = comboText + "X \n" + str(countMultiplier) + "\n"
			
	if comboText:
		$ComboLabel.text = comboText

func SetScoreLabel(score):
	$ScoreLabel.text = ("Score: " + str(score))
	
func SetComboSumLabel(comboScore):
	$ComboSumLabel.text = str(comboScore)
	ResetComboSumLabel()
	
func ResetComboSumLabel():
	$ComboSumLabel.scale.y = 1
	$ComboSumLabel.scale.x = 1
	$ComboSumLabel.modulate.a = 1
	$ComboSumLabel.set_position(OriginalComboSumLabelPosition)

func _on_timer_timeout():
	var comboScore = CalculateComboScore()
	
	SetComboSumLabel(comboScore)
	CalculateScore(comboScore)
	$ScoreLabel/SetScoreTimer.start()
	
	Points = OriginalPoints.duplicate(true)


func _on_set_score_timer_timeout():
	SetScoreLabel(Score)
