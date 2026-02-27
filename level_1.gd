extends Node2D
var timing_array = [2.335, "attack",2.983, "block",3.447, "attack",4.164, "attack",
5.407, "attack",5.873, "block",6.557, "attack",7.140, "attack",
7.798, "block",9.012, "block",10.165, "attack",11.410, "block",12.554, "attack",
13.821, "attack",14.995, "attack",16.143, "attack",17.396, "block",18.533, "block",
19.778, "attack",20.963, "block",21.589, "attack",22.144, "attack",23.368, "block"
,24.566, "attack",25.799, "block",26.993,"attack",28.167, "block",29.328, "block",
30.596, "block",31.149, "attack"]

@onready var startTime = Time.get_unix_time_from_system()
@onready var dialogue = preload("res://dialogue.tscn")
@onready var music = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _get_time():
	var time  = Time.get_unix_time_from_system() - startTime
	return time
	
func _animate_visual_inputs():
	var time_only_array = timing_array.duplicate()
	for element in time_only_array:
		if element is String:
			time_only_array.remove_at(time_only_array.find(element))
	
	return time_only_array
	
func _ready():
	_animate_visual_inputs()
	var player = preload("res://player.tscn")
	add_child(player.instantiate())
	var opponent = preload("res://opponent.tscn")
	add_child(opponent.instantiate())
	add_child(dialogue.instantiate())
	$dialogue/dialogue1/animplayer1.play("RESET")
	
func _process(_delta: float) -> void:
	pass

func process_beat_logic(time, input):
	var actual_time = time - 12
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
	else:
		accuracy_coefficient = -1
	
	print(accuracy_coefficient)
	return accuracy_coefficient

func _on_timer_timeout() -> void:
	music.play()
	$dialoguemusic.stream_paused = true
	
func _input(event: InputEvent) -> void:
	var accuracy = -.5
	if event.is_action_pressed("basic_attack"):
		$crowd_reacts.visible=true
		accuracy = process_beat_logic(_get_time(),"attack")
	elif event.is_action_pressed("block"):
		accuracy = process_beat_logic(_get_time(),"block")
	elif event.is_action_pressed("skip"):
		get_tree().change_scene_to_file('level2.tscn')
	
	if accuracy == -1:
		$crowd_reacts.play("dissed")
	elif accuracy < .2 and accuracy >=0:
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
