extends Node2D
var timing_array = [1.346, "attack",4.948, "ice",5.486, "attack",
7.319, "attack",8.754, "block",12.473, "ice",12.864, "attack",14.605, "attack",
16.131, "ice",18.449, "block",19.775, "block",22.132, "attack",23.422, "attack",
25.824, "ice",27.165, "block",29.374, "block",30.860, "attack",33.173, "attack",
34.565, "attack",35.1000, "attack",36.943, "ice",38.231, "ice",40.552, "attack",
41.900, "ice",44.273, "attack",45.583, "block",47.985, "ice",49.368, "block",
51.694, "attack",53.020, "ice",55.437, "attack",56.679, "ice",57.628, "ice"]

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
		var input_correspond = 2*(33-len(time_only_array)) + 1
		if timing_array[input_correspond] == "attack":
			$input_circles/AnimationPlayer.play("greencirc")
		elif timing_array[input_correspond] == "block":
			$input_circles/AnimationPlayer.play("purplecirc")
		elif timing_array[input_correspond] == "ice":
			$input_circles/AnimationPlayer.play("bluecirc")
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
		get_tree().change_scene_to_file('res://level4.tscn')
	if can_score == true:
		if event.is_action_pressed("basic_attack"):
			$crowd_reacts.visible=true
			accuracy = process_beat_logic(_get_time(),"attack")
			score += int(100 * accuracy)
		elif event.is_action_pressed("block"):
			$crowd_reacts.visible=true
			accuracy = process_beat_logic(_get_time(),"block")
			score += int(50 * accuracy)
		elif event.is_action_pressed("ice_attack"):
			$crowd_reacts.visible = true
			accuracy = process_beat_logic(_get_time(), "ice")
			score += int(100*accuracy)
		
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
		$score_screen/opponent_message.text = '"Don’t get too down---most newbies in Beattopia don’t come as close as you did to beating me."'
	elif 200<=score and score < 600:
		$score_screen/rank_label.text = "D"
		$score_screen/opponent_message.text = '"Don’t forget to tie your shoes next time."'
	elif 600<=score and score < 1200:
		$score_screen/rank_label.text = "C"
		$score_screen/opponent_message.text = '"Not too shabby, little man."'
	elif 1200<=score and score < 1400:
		$score_screen/rank_label.text = "B"
		$score_screen/opponent_message.text = '"Huh. Better than I thought you’d do. Props."'
	elif 1400<=score and score < 1800:
		$score_screen/rank_label.text = "A"
		$score_screen/opponent_message.text = '"You sure do know how to pack a punch, little man."'
	elif score >= 1800:
		$score_screen/rank_label.text = "S"
		$score_screen/opponent_message.text = '"How does a shorty like you learn moves like that?"'
	
	$input_circles.visible = false
	$score_label.visible = false
	$end_timer.start(-1)

func _on_end_timer_timeout() -> void:
	get_tree().change_scene_to_file('res://level4.tscn')
