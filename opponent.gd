extends Area2D

# Called when the node enters the scene tree for the first time.
var health = 100
var vulnerability_coefficient = 1
var vulnerability = true

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hit_process()

func hit_process():
	if Input.is_action_pressed("basic_attack"):
		#if self.status == "vulnerable":
		health -= vulnerability_coefficient * 10
		$CollisionShape2D/opponent_health_label.text = str(health)
		print(health)
	
		
		# decrease the health-bar shape
	
	
