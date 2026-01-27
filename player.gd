extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _basic_attack():
	if Input.is_action_pressed("basic_attack"): 
		print("Hit Opponent")
		# play some conserved animation
		### send signal to opponent
		# if that signal returns true:
		# play a connecting animation
		


func _on_hit_enemy() -> void:
	pass # Replace with function body.
