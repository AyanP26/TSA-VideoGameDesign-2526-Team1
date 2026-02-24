extends Node2D
var timing_array = [01.178, "fire",03.707, "attack",04.938, "block",
06.091, "fire",07.227, "attack",08.342, "fire",09.945, "ice",10.784, "attack",
12.248, "ice",12.248, "fire",13.264, "block",14.506, "fire",15.664, "attack",
16.843, "attack",18.057, "fire",19.361, "fire",19.735, "block",20.948, "fire",22.157,
22.797, "ice",24.527, "fire",25.749, "attack",25.749, "block",26.927, "attack",
26.927, "block",28.193, "block",28.986, "fire",29.456, "fire",30.465,
31.703, "attack",31.703, "block",33.541, "ice",34.305, "fire",35.356,
36.550, "attack",36.550, "attack",38.481, "attack",38.938, "ice",40.130,
41.419, "fire",43.167, "attack",43.747, "attack",45.031, "block",46.156,
47.999, "block",49.139, "block",51.630, "fire",52.809, "attack",
54.076, "ice",56.332, "ice",57.711, "fire"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = preload("res://player.tscn")
	add_child(player.instantiate())
	
	var opponent = preload("res://opponent.tscn")
	add_child(opponent.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
