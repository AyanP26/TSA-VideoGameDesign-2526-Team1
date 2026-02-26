extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("basic_attack"):
		$AnimatedSprite2D.play("kicking")
	elif event.is_action_pressed("block"):
		$AnimatedSprite2D.play("kicking")
	elif event.is_action_pressed("ice_attack"):
		$AnimatedSprite2D.play("kicking")
	elif event.is_action_pressed("fireball"):
		$AnimatedSprite2D.play("kicking")
		
func _process(_delta: float) -> void:
	pass
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "kicking":
		$AnimatedSprite2D.play("default")
