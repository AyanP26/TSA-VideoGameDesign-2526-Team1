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
	if health > 0:
		if Input.is_action_just_pressed("basic_attack"):
			#if self.status == "vulnerable":
			health -= vulnerability_coefficient * 5
			$CollisionShape2D/opponent_health_label.text = str(health)
			print(health)
		elif Input.is_action_just_pressed("ice_attack"):
			health -= vulnerability_coefficient * 15
			$CollisionShape2D/opponent_health_label.text = str(health)
			print(health) 
	else:	
		get_tree().change_scene_to_file('level2.tscn')# decrease the health-bar shape
	
	
