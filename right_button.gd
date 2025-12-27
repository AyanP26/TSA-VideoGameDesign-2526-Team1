extends RigidBody2D

var speed = 400
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	var appear_or_not = randi_range(0,1)
	if appear_or_not == 1:
		show()
		velocity = Vector2.UP * speed
		position += velocity * delta
		
