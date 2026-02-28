extends Node2D
var timing_array = [2.350, "attack",3.563, "block",4.840, "attack",
7.197, "block",9.560, "block",11.784, "attack",14.532, "block",16.729, "attack",
19.137, "attack",21.441, "attack",23.962, "attack",25.370, "block",
26.079, "block",26.643, "attack",27.225, "attack",27.803, "attack",
28.839, "attack",30.161, "block",30.907, "attack",
31.457, "attack",32.024, "attack",32.612, "attack",33.607, "block",35.044, "attack",
35.700, "block",36.228, "attack",36.930, "block",37.515, "attack",38.470, "attack",
39.838, "block", 40.486, "block",41.028, "attack",42.656, "block",45.405, "attack",
47.989, "block", 50.326, "block",52.661, "block",54.986, "attack",
57.423, "attack",59.858, "attack",62.349, "attack"]

var score = 0
@onready var startTime = Time.get_unix_time_from_system()
@onready var dialogue = preload("res://dialogue.tscn")
@onready var music = $AudioStreamPlayer2D
var time_only_array = []
var can_score = false
const timer_length = 12

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

# Called when the node enters the scene tree for the first time.
func _ready():
	make_time_array()
	var player = preload("res://player.tscn")
	add_child(player.instantiate())
	var opponent = preload("res://opponent.tscn")
	add_child(opponent.instantiate())
	add_child(dialogue.instantiate())
	$dialogue/dialogue1/animplayer1.play("RESET")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if len(time_only_array) < 1:
		pass
		
	elif _get_time() >= time_only_array[0]:
		var input_correspond = 2*(41-len(time_only_array)) + 1
		print(input_correspond, "  ", timing_array[input_correspond])
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
	$dialoguemusic.stream_paused = true
	can_score = true
	music.play()


func _input(event: InputEvent) -> void:
	var accuracy = -1
	if event.is_action_pressed("skip"):
		get_tree().change_scene_to_file('res://level3.tscn')
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
	if score < 200:
		$score_screen/rank_label.text = "F"
		$score_screen/opponent_message.text = '"Don’t sweat it, bud! You just need to put in some elbow grease, yeah?"'
	elif 200<=score and score < 600:
		$score_screen/rank_label.text = "D"
		$score_screen/opponent_message.text = '"Hey, we’re all beginners here, right? Don’t trip about it."'
	elif 600<=score and score < 1200:
		$score_screen/rank_label.text = "C"
		$score_screen/opponent_message.text = '"No sweat, man, that was fresh!"'
	elif 1200<=score and score < 1800:
		$score_screen/rank_label.text = "B"
		$score_screen/opponent_message.text = '"Rock on, man! That was sick!"'
	elif 1800<=score and score < 2400:
		$score_screen/rank_label.text = "A"
		$score_screen/opponent_message.text = '"Woah, dude… you sure you’re only a beginner street dancer?"'
	elif score >= 2400:
		$score_screen/rank_label.text = "S"
		$score_screen/opponent_message.text = '"Um… are you looking to take anyone under your wing…? I could use a little guidance…"'
	
	
	$input_circles.visible = false
	$score_label.visible = false
	$end_timer.start(-1)

func _on_end_timer_timeout() -> void:
	get_tree().change_scene_to_file('res://level3.tscn')
