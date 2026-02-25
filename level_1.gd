extends Node2D
var timing_array = [02.335, "attack",02.983, "block",03.447, "attack",04.164, "attack",
05.407, "attack",05.873, "block",06.557, "attack",07.140, "attack",
07.798, "block",09.012, "block",10.165, "attack",11.410, "block",12.554, "attack",
13.821, "attack",14.995, "attack",16.143, "attack",17.396, "block",18.533, "block",
19.778, "attack",20.963, "block",21.589, "attack",22.144, "attack",23.368, "block"
,24.566, "attack",25.799, "block",26.993,"attack",28.167, "block",29.328, "block",
30.596, "block",31.149, "attack"]

@onready var startTime = Time.get_unix_time_from_system()
@onready var dialogue = preload("res://dialogue.tscn")
@onready var music = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _get_time() -> float:
	var time  = Time.get_unix_time_from_system() - startTime
	return time

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	
func _ready():
	var player = preload("res://player.tscn")
	add_child(player.instantiate())
	var opponent = preload("res://opponent.tscn")
	add_child(opponent.instantiate())
	add_child(dialogue.instantiate())
	$dialogue/dialogue1/AnimationPlayer.play()
	wait(6)
	$dialogue/dialogue2.visible = true
	$dialogue/dialogue2/AnimationPlayer.play()
	wait(6)
	music.play()
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("skip"):
		get_tree().change_scene_to_file('level2.tscn')
		
