extends Node2D
var timing_array = [01.346, "attack",04.948, "ice",05.486, "attack",
07.319, "attack",08.754, "block",12.473, "ice",12.864, "attack",14.605, "attack",
16.131, "ice",18.449, "block",19.775, "block",22.132, "attack",23.422, "attack",
25.824, "ice",27.165, "block",29.374, "block",30.860, "attack",33.173, "attack",34.565,
35.1000, "attack",36.943, "ice",38.231, "ice",40.552, "attack",41.900,
44.273, "attack",45.583, "block",47.985, "ice",49.368, "block",51.694, "attack",53.020,
55.437, "attack",56.679, "ice",57.628]

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = preload("res://player.tscn")
	add_child(player.instantiate())
	
	var opponent = preload("res://opponent.tscn")
	add_child(opponent.instantiate())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("skip"):
		get_tree().change_scene_to_file('level4.tscn')
func _song_play() -> void:
	#wait after dialogue ends and start music
	pass
