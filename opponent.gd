extends Area2D

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	var current_scene = get_tree().current_scene.name
	if current_scene == "Level2":
		$CollisionShape2D/AnimatedSprite2D.animation = "level2animation"
	elif current_scene == "Level3":
		$CollisionShape2D/AnimatedSprite2D.animation = "level3animation"
	elif current_scene == "Level4":
		$CollisionShape2D/AnimatedSprite2D.animation = "level4animation"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
