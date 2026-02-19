extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_basic_attack()
	
func _basic_attack():
	if Input.is_action_just_pressed("basic_attack"): 
		print("Basic Attack")
		# play some conserved animation
		### send signal to opponent
		# if that signal returns true:
		# play a connecting animation

func _ice_attack():
	if Input.is_action_just_pressed("ice_attack"):
		print("Ice Attack")		

func _on_hit_enemy() -> void:
	pass # Replace with function body.
