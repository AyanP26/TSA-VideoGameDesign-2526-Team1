extends Area2D

# Called when the node enters the scene tree for the first time.
var score = 0
var accuracy_coefficient = 1
var vulnerability = true
var song_is_playing = true
func _find_difference_keypress_and_song():
	return accuracy_coefficient
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
	if song_is_playing == true:
		if Input.is_action_just_pressed("basic_attack"):
			#if self.status == "vulnerable":
			score += int(accuracy_coefficient * 5)
			$CollisionShape2D/opponent_score_label.text = str(score)
		
		elif Input.is_action_just_pressed("block"):
			if accuracy_coefficient != 0 and accuracy_coefficient !=1:
				score -= 2*int(1/(accuracy_coefficient))
			elif accuracy_coefficient == 1:
				pass
			$CollisionShape2D/opponent_score_label.text = str(score)
			
		elif Input.is_action_just_pressed("ice_attack"):
			score += int(accuracy_coefficient * 15)
			$CollisionShape2D/opponent_score_label.text = str(score)
			
		elif Input.is_action_just_pressed("fireball"):
			score += int(accuracy_coefficient * 20)
			$CollisionShape2D/opponent_score_label.text = str(score)
			
	else:
		var current_scene = get_tree().current_scene.name
		if current_scene == "Level1":
			get_tree().change_scene_to_file('level2.tscn')
		if current_scene == "Level2":
			get_tree().change_scene_to_file('level3.tscn')
		if current_scene == "Level3":
			get_tree().change_scene_to_file('level4.tscn')
	
