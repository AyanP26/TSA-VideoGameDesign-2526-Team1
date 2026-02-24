extends Node2D
var timing_array = [02.350, "attack",03.563, "block",04.840, "attack",
07.197, "block",09.560, "block",11.784, "attack",14.532, "block",16.729, "attack",
19.137, "attack",21.441, "attack",23.962, "attack",25.370,
26.079, "block",26.643, "attack",27.225, "attack",27.803,
28.839, "attack",30.161, "block",30.907, "attack",
31.457, "attack",32.024, "attack",32.612, "attack",33.607, "block",35.044, "attack",
35.700, "block",36.228, "attack",36.930, "block",37.515, "attack",38.470, "attack",39.838,
40.486, "block",41.028, "attack",42.656, "block",45.405, "attack",47.989,
50.326, "block",52.661, "block",54.986, "attack",57.423, "attack",59.858, "attack",62.349, "attack"]

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = preload("res://player.tscn")
	add_child(player.instantiate())
	
	var opponent = preload("res://opponent.tscn")
	add_child(opponent.instantiate())
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("skip"):
		get_tree().change_scene_to_file('level3.tscn')
func _song_play() -> void:
	#wait after dialogue ends and start music
	pass
