extends Area2D

# Called when the node enters the scene tree for the first time.
var health = 100
var vulnerability_coefficient = 1

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hit_process():
	if Input.is_action_pressed("basic_attack"):
		#if self.status == "vulnerable":
		health -= vulnerability_coefficient * 10
		print(health)
		print("health decreased")
		# decrease the health-bar shape
	
	
