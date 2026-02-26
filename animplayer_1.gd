extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "RESET":
		print("true")
		$dialogue/dialogue2.visible = true
		$dialogue/dialogue2/animplayer2.play("RESET")
