extends Area2D

# Called when the node enters the scene tree for the first time.
var health = 100
var vulnerability_coefficient = 1
var vulnerability = true
func _ready() -> void:
	var current_scene = get_tree().current_scene.name
	if current_scene == "Level2":
		$CollisionShape2D/AnimatedSprite2D.animation = "level2animation"
	elif current_scene == "Level3":
		$CollisionShape2D/AnimatedSprite2D.animation = "level3animation"
	elif current_scene == "Level4":
		$CollisionShape2D/AnimatedSprite2D.animation = "level4animation"

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
		elif Input.is_action_just_pressed("fireball"):
			health -= vulnerability_coefficient * 20
			$CollisionShape2D/opponent_health_label.text = str(health)
			print(health)
	else:
		var current_scene = get_tree().current_scene.name
		if current_scene == "Level1":
			get_tree().change_scene_to_file('level2.tscn')
		if current_scene == "Level2":
			get_tree().change_scene_to_file('level3.tscn')
		if current_scene == "Level3":
			get_tree().change_scene_to_file('level4.tscn')
	
