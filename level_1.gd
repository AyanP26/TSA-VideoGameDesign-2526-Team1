extends Node2D
var timing_array = [2.335, "attack",2.983, "block",3.447, "attack",4.164, "attack",
5.407, "attack",5.873, "block",6.557, "attack",7.140, "attack",
7.798, "block",9.012, "block",10.165, "attack",11.410, "block",12.554, "attack",
13.821, "attack",14.995, "attack",16.143, "attack",17.396, "block",18.533, "block",
19.778, "attack",20.963, "block",21.589, "attack",22.144, "attack",23.368, "block"
,24.566, "attack",25.799, "block",26.993,"attack",28.167, "block",29.328, "block",
30.596, "block",31.149, "attack"]
const timer_length = 12

var score = 0
@onready var startTime = Time.get_unix_time_from_system()
@onready var dialogue = preload("res://dialogue.tscn")
@onready var music = $AudioStreamPlayer2D
var time_only_array = []
var can_score = false
# Called when the node enters the scene tree for the first time.
func _get_time():
	var time  = Time.get_unix_time_from_system() - startTime
	return time
	
func make_time_array():
	time_only_array = timing_array.duplicate()
	for element in time_only_array:
		if element is String:
			time_only_array.remove_at(time_only_array.find(element))
	#print(time_only_array)
	for element2 in time_only_array:
		time_only_array[time_only_array.find(element2)] += timer_length - 0.25
	#print(time_only_array)
	return time_only_array

func _ready():
	make_time_array()
	var player = preload("res://player.tscn")
	add_child(player.instantiate())
	var opponent = preload("res://opponent.tscn")
	add_child(opponent.instantiate())
	add_child(dialogue.instantiate())
	$dialogue/dialogue1/animplayer1.play("RESET")
	
func _process(_delta: float) -> void:
	if len(time_only_array) < 1:
		pass
		
	elif _get_time() >= time_only_array[0]:
		var input_correspond = 2*(30-len(time_only_array)) + 1
		if timing_array[input_correspond] == "attack":
			$input_circles/AnimationPlayer.play("greencirc")
		elif timing_array[input_correspond] == "block":
			$input_circles/AnimationPlayer.play("purplecirc")
		time_only_array.remove_at(0)

func process_beat_logic(time, input):
	var actual_time = time - timer_length
	var new_array = timing_array.duplicate()
	var second_array = []
	var third_array = []
	var accuracy_coefficient = 0
	for index in new_array:
		if index is float:
			if abs(actual_time-index) <= .25:
				second_array.append(index)
				second_array.append(new_array[new_array.find(index)+1])
	for index2 in second_array:
		if index2 is String:
			if index2 == input:
				third_array.append(second_array[second_array.find(index2)-1])
	if len(third_array) > 0:
		accuracy_coefficient = 1 - 3*abs(actual_time-third_array[0])
		new_array.remove_at(timing_array.find(third_array[0]))
		new_array.remove_at(timing_array.find(third_array[0]+1))
	else:
		accuracy_coefficient = -.2
	
	#print(accuracy_coefficient)
	return accuracy_coefficient

func _on_timer_timeout() -> void:
	music.play()
	$dialoguemusic.stream_paused = true
	can_score = true
	
func _input(event: InputEvent) -> void:
	var accuracy = -1
	if event.is_action_pressed("skip"):
		get_tree().change_scene_to_file('level2.tscn')
	if can_score == true:
		if event.is_action_pressed("basic_attack"):
			$crowd_reacts.visible=true
			accuracy = process_beat_logic(_get_time(),"attack")
			score += int(100 * accuracy)
		elif event.is_action_pressed("block"):
			$crowd_reacts.visible=true
			accuracy = process_beat_logic(_get_time(),"block")
			score += int(50 * accuracy)
		
		if accuracy == -.2:
			$crowd_reacts.play("dissed")
		elif accuracy < .2 and accuracy >= 0:
			$crowd_reacts.play("eh")
		elif accuracy < .4 and accuracy >= .2:
			$crowd_reacts.play("nice")
		elif accuracy < .6 and accuracy >= .4:
			$crowd_reacts.play("fly")
		elif accuracy <.7 and accuracy >= .6:
			$crowd_reacts.play("cool")
		elif accuracy <.9 and accuracy >= .7:
			$crowd_reacts.play("fire")
		elif accuracy >= .9:
			$crowd_reacts.play("rad")
	
		$score_label.text = str(score)

func _on_audio_stream_player_2d_finished() -> void:
	var score_screen = preload("res://score_screen.tscn")
	add_child(score_screen.instantiate())
	$score_screen/score_label.text = str(score)
	if score < 100:
		$score_screen/rank_label.text = "F"
		$score_screen/opponent_message.text = '"Uh… how about we do another trainin’ round…?"'
	elif 100<=score and score < 300:
		$score_screen/rank_label.text = "D"
		$score_screen/opponent_message.text = '"Little slips and slides adds… flair, ya know…?"'
	elif 300<=score and score < 600:
		$score_screen/rank_label.text = "C"
		$score_screen/opponent_message.text = '"Clean it up some and you’ll be unstoppable!"'
	elif 600<=score and score < 900:
		$score_screen/rank_label.text = "B"
		$score_screen/opponent_message.text = '"Fly moves, MC!"'
	elif 900<=score and score < 1200:
		$score_screen/rank_label.text = "A"
		$score_screen/opponent_message.text = '"Keep this up and you’ll be the next big Dance Champ in no time!"'
	elif score >= 1200:
		$score_screen/rank_label.text = "S"
		$score_screen/opponent_message.text = '"Wow, MC! I don’t think I even needed to teach ya anythin’!"'
	
	
	$input_circles.visible = false
	$score_label.visible = false
	$end_timer.start(-1)

func _on_end_timer_timeout() -> void:
	get_tree().change_scene_to_file('level2.tscn')
